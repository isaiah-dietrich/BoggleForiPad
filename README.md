# Boggle Board (iPad Landscape)

This is a single-page, client-side web app that displays a shared 4×4 Boggle board designed for in-person multiplayer use on an iPad in landscape mode.

Features:
- Full-screen 4×4 board that scales to fill as much of the screen as possible
- Uses the official 16 Boggle dice
- Dice order is shuffled and a random face from each die is selected on each generation
- Each tile face is randomly rotated by 0°, 90°, 180°, or 270°
- Small unobtrusive shuffle button to regenerate the board
- No timer, scoring, word validation, or extra UI

How to use:
1. Open [index.html](index.html) in Safari on an iPad (landscape recommended).
2. Tap the shuffle button to regenerate the board.
3. Consider adding the page to the home screen for a cleaner fullscreen experience.

Notes:
- The app attempts to lock orientation using the Screen Orientation API when possible. Some browsers require the page to be added to the home screen or require a user gesture for locking to work.
- All logic runs client-side in `script.js`.
