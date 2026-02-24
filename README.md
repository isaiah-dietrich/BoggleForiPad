# Boggle Monorepo

This repository is structured to keep the website and iPad app as separate applications while sharing core game logic and assets.

## Structure

- `apps/web`: Existing web app (HTML/CSS/JS)
- `apps/ipad`: iPad app workspace (Capacitor or native iOS)
- `packages/game-core`: Shared game logic
- `packages/shared-assets`: Shared non-code assets (word lists, audio, icons)
- `docs`: Architecture and development notes

## Quick Start

- Web app: open `apps/web/index.html` in a browser.
- iPad app: initialize your iOS app project inside `apps/ipad/ios`.

## Notes

The original website files were moved from the repository root to `apps/web` to support separate app targets.
