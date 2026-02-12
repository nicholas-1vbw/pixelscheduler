# Implementation Plan: LivePreview for Settings

This plan outlines the steps to implement real-time previewing of settings on the actual Timer Beam, with explicit Save/Cancel persistence logic.

## Phase 1: State Management Refactoring
Goal: Separate persistent settings from the active "session" settings to support real-time preview and restoration.

- [x] Task: Update `SettingsManager` to support a "draft" or "session" state. 35b9a9d
    - [x] Task: Implement a mechanism to capture a snapshot of current settings. 35b9a9d
    - [x] Task: Add a `revert()` method to restore settings from a snapshot. 35b9a9d
    - [x] Task: Ensure `UserDefaults` is only updated when an explicit `save()` is called. 35b9a9d
- [x] Task: Update `SettingsViewModel` to observe and publish changes to the "session" state. 35b9a9d
- [x] Task: Conductor - User Manual Verification 'Phase 1: State Management' (Protocol in workflow.md)

## Phase 2: LivePreview Integration
Goal: Connect the `SettingsView` changes directly to the `BeamView` via the updated state management.

- [ ] Task: Ensure `BeamView` and `BeamWindow` react immediately to changes in the `SettingsManager` session state.
- [ ] Task: Verify that all UI controls in `SettingsView` (colors, position, thickness) trigger a redraw of the `BeamView`.
- [ ] Task: Conductor - User Manual Verification 'Phase 2: LivePreview Integration' (Protocol in workflow.md)

## Phase 3: Save/Cancel/Restoration Logic
Goal: Implement the UI and lifecycle events for persisting or discarding changes.

- [ ] Task: Add "Save" and "Cancel" buttons to `SettingsView`.
    - [ ] Task: "Save" button triggers `SettingsManager.save()`.
    - [ ] Task: "Cancel" button triggers `SettingsManager.revert()` and closes the window.
- [ ] Task: Implement window lifecycle hooks to trigger restoration.
    - [ ] Task: Restore settings if the `SettingsView` is closed without saving.
    - [ ] Task: Ensure settings are restored on app termination if unsaved.
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Save/Cancel/Restoration Logic' (Protocol in workflow.md)

## Phase 4: Final Polishing & Edge Cases
Goal: Ensure a smooth user experience and handle edge cases.

- [ ] Task: Audit `AppDelegate` and `PixelSchedulerApp` for proper initialization/teardown of the settings session.
- [ ] Task: Verify multi-display behavior (if applicable) during live preview.
- [ ] Task: Conductor - User Manual Verification 'Phase 4: Final Polishing' (Protocol in workflow.md)
