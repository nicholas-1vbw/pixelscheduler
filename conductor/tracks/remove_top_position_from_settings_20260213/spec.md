# Specification: Remove 'Top' Position from Settings UI

## Overview
To prevent the Timer Beam from overlapping with the macOS menu bar and potentially blocking user interactions, the "Top" position option will be removed from the Settings UI. However, the underlying support for the "Top" position will be maintained in the codebase as a "secret" configuration to ensure backward compatibility for existing users and to allow for manual configuration via `UserDefaults`.

## Functional Requirements
- **UI Modification:** Remove the "Top" option from the position picker in `SettingsView`.
- **Capability Retention:** Keep the `Top` case in the `BeamPosition` enum and all associated rendering/positioning logic in `BeamView`, `BeamWindow`, and `NowIndicatorShape`.
- **Legacy Support:** If a user already has "Top" selected in their persistent settings, the app must continue to function correctly with the beam at the top.
- **Picker Behavior:** If the current position is "Top", the Settings picker will display the available options (Bottom, Left, Right). If the user switches away from "Top", they will not be able to re-select it through the UI.

## Non-Functional Requirements
- **Zero Regression:** No impact on the functionality of Bottom, Left, or Right positions.
- **Maintainability:** Ensure the "Top" logic remains easy to re-enable if a future solution for menu bar overlap is implemented.

## Acceptance Criteria
1. Open Settings -> General. The "Position" picker only lists "Bottom", "Left", and "Right".
2. Selecting "Bottom", "Left", or "Right" correctly moves the beam.
3. Manually setting the position to `top` in `UserDefaults` (via terminal or legacy install) still results in the beam appearing at the top of the screen.
4. Existing tests for `BeamPosition` and frame calculations still pass.

## Out of Scope
- Adding a "Menu Bar Offset" feature to make Top usable without overlap.
- Migrating existing "Top" users to "Bottom" automatically.
