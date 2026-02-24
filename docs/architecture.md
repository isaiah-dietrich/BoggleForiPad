# Architecture

## Apps

- `apps/web` contains the browser implementation.
- `apps/ipad` contains the iPad implementation and iOS project files.

## Shared Packages

- `packages/game-core` should contain reusable gameplay logic: board generation, scoring, timer rules, dictionary validation interfaces.
- `packages/shared-assets` should contain reusable resources shared by both app targets.

## Boundaries

- App folders own UI and platform-specific behavior.
- Shared packages own reusable logic and assets.
