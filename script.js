// Boggle board script
// Written to run entirely client-side. No backend required.

// Official 16 Boggle dice (faces defined exactly as provided)
const DICE = [
  ['R','I','F','O','B','X'],
  ['I','F','E','H','E','Y'],
  ['D','E','N','O','W','S'],
  ['U','T','O','K','N','D'],
  ['H','M','S','R','A','O'],
  ['L','U','P','E','T','S'],
  ['A','C','T','I','O','A'],
  ['Y','L','G','K','U','E'],
  ['Q','B','M','J','O','A'],
  ['E','H','I','S','P','N'],
  ['V','E','T','I','G','N'],
  ['B','A','L','I','Y','T'],
  ['E','Z','A','V','N','D'],
  ['R','A','L','E','S','C'],
  ['U','W','I','L','R','G'],
  ['P','A','C','E','M','D']
];

const ROTATIONS = [0,90,180,270]; // allowed tile rotations

const boardEl = document.getElementById('board');
const shuffleBtn = document.getElementById('shuffleBtn');

/**
 * Fisher-Yates shuffle — returns a new shuffled copy of the array
 * Used to randomize the order of the 16 dice each time we generate the board.
 */
function shuffleArray(arr){
  const a = arr.slice();
  for(let i=a.length-1;i>0;i--){
    const j = Math.floor(Math.random()*(i+1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

/**
 * Selects a single random face from a die (array of 6 faces).
 * This models physically rolling each die and showing one upward face.
 */
function rollDie(die){
  const idx = Math.floor(Math.random()*die.length);
  return die[idx];
}

/**
 * Build board data: shuffle dice order, roll each die, and pick a random rotation for each tile.
 * Returns array of objects: { letter, rotation }
 * - Dice shuffling: Fisher-Yates via shuffleArray ensures unbiased permutation of the 16 dice.
 * - Face selection: rollDie picks a uniform random face from the selected die.
 * - Rotation: choose randomly from 0°,90°,180°,270° to mimic physical cube orientation.
 */
function buildBoard(){
  const shuffledDice = shuffleArray(DICE);
  return shuffledDice.map(die => ({
    letter: rollDie(die),
    rotation: ROTATIONS[Math.floor(Math.random()*ROTATIONS.length)]
  }));
}

/**
 * Render the 4x4 board DOM based on board data.
 * Each tile is a `.tile` with a `.face` child; rotation applied to the face element.
 */
function renderBoard(boardData){
  boardEl.innerHTML = '';
  boardData.forEach((cell, idx) => {
    const tile = document.createElement('div');
    tile.className = 'tile';
    tile.setAttribute('role','gridcell');
    // Create three layers to simulate a 3D tile: top face (with letter),
    // right face (thinner darker side), and bottom/front face (darker underside).
    const face = document.createElement('div');
    face.className = 'face face-top';
    face.style.transform = `rotate(${cell.rotation}deg)`; // rotate only the top face and its contents

    // Create the letter directly on the curved top surface (printed look)
    const letterEl = document.createElement('div');
    letterEl.className = 'letter';
    letterEl.textContent = cell.letter;
    face.appendChild(letterEl);

    const sideRight = document.createElement('div');
    sideRight.className = 'side side-right';

    const sideBottom = document.createElement('div');
    sideBottom.className = 'side side-bottom';

    // Append in z-order: bottom side, right side, then top face
    tile.appendChild(sideBottom);
    tile.appendChild(sideRight);
    tile.appendChild(face);
    boardEl.appendChild(tile);
  });
}



function generateBoard(){
  const data = buildBoard();
  renderBoard(data);
}

function init(){
  // Initial board
  generateBoard();

  // Orientation lock removed per user request; no locking attempted.

  // Shuffle button regenerates the board with a new dice shuffle and face selection.
  // No confirmation, no timer — immediate regeneration to a new random board.
  shuffleBtn.addEventListener('click', () => {
    generateBoard();
    // attempt to (re)acquire wake lock on explicit user action
    requestWakeLock().catch(() => {});
  });

  // --- Wake Lock (prevent screen sleep) ---
  // Best-effort: use the Screen Wake Lock API when available. Many browsers
  // (including modern Safari) require a user gesture to acquire a wake lock.
  // We attempt to acquire on first user interaction and re-acquire when
  // the page becomes visible again.
  let wakeLock = null;
  let audioFallback = null;

  async function requestWakeLock(){
    try{
      if('wakeLock' in navigator && navigator.wakeLock.request){
        wakeLock = await navigator.wakeLock.request('screen');
        // If the lock is released by the UA, try to detect and re-acquire later
        wakeLock.addEventListener('release', () => {
          wakeLock = null;
        });
        return wakeLock;
      } else {
        // No Wake Lock API available. There are fallbacks (play a muted looping
        // video) but they can be unreliable on iOS Safari and may require a
        // larger data URI. We avoid those here and rely on the native API when
        // available.
        return null;
      }
    }catch(err){
      // Could fail if browser denies request; swallow the error — app still works.
      wakeLock = null;
      return null;
    }
  }

  // Fallback: create a silent looping AudioBufferSourceNode to help prevent sleep
  // on browsers that don't support the Wake Lock API. This is best-effort — some
  // platforms may still ignore it, but it's lightweight and requires only a
  // user gesture to start.
  async function startSilentAudioLoop(){
    try{
      if(audioFallback) return audioFallback; // already running
      const AudioCtx = window.AudioContext || window.webkitAudioContext;
      if(!AudioCtx) return null;
      const ctx = new AudioCtx();
      // create 1 second of silent audio
      const buffer = ctx.createBuffer(1, ctx.sampleRate * 1, ctx.sampleRate);
      const src = ctx.createBufferSource();
      src.buffer = buffer;
      src.loop = true;
      // connect to destination through a gain of 0 so it's inaudible
      const gain = ctx.createGain();
      gain.gain.value = 0;
      src.connect(gain);
      gain.connect(ctx.destination);
      src.start(0);
      audioFallback = { ctx, src, gain };
      return audioFallback;
    }catch(e){
      audioFallback = null;
      return null;
    }
  }

  function stopSilentAudioLoop(){
    try{
      if(!audioFallback) return;
      audioFallback.src.stop();
      audioFallback.ctx.close();
      audioFallback = null;
    }catch(e){
      audioFallback = null;
    }
  }

  // Attempt to acquire wake lock on first user gesture (necessary on many UAs)
  const tryWakeOnUserGesture = () => {
    requestWakeLock().catch(()=>{}).then((wl)=>{
      if(!wl){
        // If Wake Lock API not available or failed, try the audio fallback
        startSilentAudioLoop().catch(()=>{});
      }
    });
    window.removeEventListener('touchstart', tryWakeOnUserGesture);
    window.removeEventListener('mousedown', tryWakeOnUserGesture);
  };
  window.addEventListener('touchstart', tryWakeOnUserGesture, { once:true });
  window.addEventListener('mousedown', tryWakeOnUserGesture, { once:true });

  // Re-acquire wake lock when the document becomes visible again
  document.addEventListener('visibilitychange', async () => {
    if(document.visibilityState === 'visible'){
      const wl = await requestWakeLock().catch(()=>null);
      if(!wl){
        // try re-starting audio fallback when returning to visible
        startSilentAudioLoop().catch(()=>{});
      }
    }
  });

  // Stop audio fallback when page is unloaded
  window.addEventListener('pagehide', () => {
    stopSilentAudioLoop();
  });

  // No orientation recommendation shown (user requested removal).
}

document.addEventListener('DOMContentLoaded', init);
