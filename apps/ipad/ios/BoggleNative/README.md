# BoggleNative (SwiftUI iPad)

Native SwiftUI implementation of the Boggle board UI and shuffle logic.

## Project Layout

- `BoggleNativeApp.swift`: App entry point
- `Models/`: Dice, tile, and board generation logic
- `ViewModels/`: Observable game state and actions
- `Views/`: Native SwiftUI board/tile/button views
- `Resources/Info.plist`: iPad-only + landscape-only app settings

## Create Minimal Xcode Project

1. In Xcode, create a new **iOS App** named `BoggleNative` using **SwiftUI**.
2. Remove default generated files except app target settings.
3. Copy these source files into the app target, preserving folders.
4. Replace target Info.plist with `Resources/Info.plist` (or copy keys).
5. In target settings:
   - Device: iPad
   - Supported Interface Orientations (iPad): Landscape Left + Right
   - Requires Full Screen: Yes

This app intentionally includes only:
- 4x4 board
- official dice shuffle and roll
- random tile rotation
- single shuffle button
