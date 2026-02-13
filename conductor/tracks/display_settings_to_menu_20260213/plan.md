# Implementation Plan: Display Settings to Menu Transition

## Phase 1: Preparation and Testing
- [x] Task: Create unit tests for `StatusBarController` to verify dynamic menu generation. 675f5b0
- [x] Task: Create unit tests for `SettingsManager` to ensure `selectedDisplayName` is correctly persisted and resolved when updated via non-UI paths. 6c085b9
- [ ] Task: Conductor - User Manual Verification 'Phase 1' (Protocol in workflow.md)

## Phase 2: Status Bar Menu Enhancement
- [ ] Task: Update `StatusBarController` to include a "Display" submenu.
    - [ ] Add a method to build the Display submenu dynamically based on `NSScreen.screens`.
    - [ ] Implement a menu action to switch the active display and update `SettingsManager`.
    - [ ] Add logic to refresh the submenu when it's about to open (to handle display connection/disconnection).
- [ ] Task: Write tests to verify that selecting a display in the menu updates `SettingsManager.selectedDisplayName`.
- [ ] Task: Conductor - User Manual Verification 'Phase 2' (Protocol in workflow.md)

## Phase 3: Settings UI Cleanup
- [ ] Task: Remove the "Display" section from `SettingsView.swift`.
- [ ] Task: Update `SettingsViewModel.swift` to remove `availableScreens` and `selectedDisplayName` if they are no longer needed by the view.
- [ ] Task: Verify that `SettingsViewModel` still correctly interacts with `SettingsManager` for other settings.
- [ ] Task: Conductor - User Manual Verification 'Phase 3' (Protocol in workflow.md)

## Phase 4: Final Integration and Verification
- [ ] Task: Verify the end-to-end flow:
    - [ ] Connect/disconnect a display (if possible) and check menu updates.
    - [ ] Switch display via menu and confirm Timer Beam moves.
    - [ ] Restart app and confirm display selection persists.
- [ ] Task: Conductor - User Manual Verification 'Phase 4' (Protocol in workflow.md)
