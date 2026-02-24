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
const rotateHint = document.getElementById('rotateHint');

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

    const face = document.createElement('div');
    face.className = 'face';
    face.textContent = cell.letter;
    face.style.transform = `rotate(${cell.rotation}deg)`; // rotate the letter/tile face

    tile.appendChild(face);
    boardEl.appendChild(tile);
  });
}

/**
 * Attempt to lock orientation to landscape using the Screen Orientation API.
 * This API requires a secure context and may require a user gesture on some platforms.
 * We call it where possible; if it fails we silently ignore the error.
 */
async function lockOrientationLandscape(){
  try{
    if(screen.orientation && screen.orientation.lock){
      await screen.orientation.lock('landscape');
    } else if(screen.lockOrientation){
      // older vendor-prefixed APIs
      screen.lockOrientation('landscape');
    }
  }catch(e){
    // Locking may fail (e.g., not in standalone or insecure context). No-op.
  }
}

function checkOrientationHint(){
  // Show hint if portrait (height > width)
  if(window.innerHeight > window.innerWidth){
    rotateHint.hidden = false;
  } else {
    rotateHint.hidden = true;
  }
}

function generateBoard(){
  const data = buildBoard();
  renderBoard(data);
}

function init(){
  // Initial board
  generateBoard();

  // Try to lock orientation on first user interaction if possible
  const tryLock = () => {
    lockOrientationLandscape();
    // don't keep re-adding; one attempt is sufficient
    window.removeEventListener('touchstart', tryLock);
    window.removeEventListener('mousedown', tryLock);
  };
  window.addEventListener('touchstart', tryLock, { once:true });
  window.addEventListener('mousedown', tryLock, { once:true });

  // Shuffle button regenerates the board with a new dice shuffle and face selection.
  // No confirmation, no timer — immediate regeneration to a new random board.
  shuffleBtn.addEventListener('click', () => {
    generateBoard();
    // try orientation lock again on explicit user action
    lockOrientationLandscape();
  });

  // Recompute orientation hint when viewport changes
  window.addEventListener('resize', checkOrientationHint);
  window.addEventListener('orientationchange', checkOrientationHint);
  checkOrientationHint();
}

document.addEventListener('DOMContentLoaded', init);
