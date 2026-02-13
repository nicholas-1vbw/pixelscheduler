# Implementation Plan: Display Settings to Menu Transition

## Phase 1: Preparation and Testing [checkpoint: f69b633]
- [x] Task: Create unit tests for `StatusBarController` to verify dynamic menu generation. 675f5b0
- [x] Task: Create unit tests for `SettingsManager` to ensure `selectedDisplayName` is correctly persisted and resolved when updated via non-UI paths. 6c085b9
- [x] Task: Conductor - User Manual Verification 'Phase 1' (Protocol in workflow.md) f69b633

## Phase 2: Status Bar Menu Enhancement [checkpoint: 4e0322e]
- [x] Task: Update `StatusBarController` to include a "Display" submenu. 675f5b0
    - [x] Add a method to build the Display submenu dynamically based on `NSScreen.screens`. 675f5b0
    - [x] Implement a menu action to switch the active display and update `SettingsManager`. 675f5b0
    - [x] Add logic to refresh the submenu when it's about to open (to handle display connection/disconnection). 675f5b0
- [x] Task: Write tests to verify that selecting a display in the menu updates `SettingsManager.selectedDisplayName`. 7d880ca
- [x] Task: Conductor - User Manual Verification 'Phase 2' (Protocol in workflow.md) 4e0322e

## Phase 3: Settings UI Cleanup [checkpoint: 533d161]
- [x] Task: Remove the "Display" section from `SettingsView.swift`. 8039d0b
- [x] Task: Update `SettingsViewModel.swift` to remove `availableScreens` and `selectedDisplayName` if they are no longer needed by the view. 8039d0b
- [x] Task: Verify that `SettingsViewModel` still correctly interacts with `SettingsManager` for other settings. 8039d0b
- [x] Task: Conductor - User Manual Verification 'Phase 3' (Protocol in workflow.md) 533d161

## Phase 4: Final Integration and Verification [checkpoint: 2bbbbb7]
- [x] Task: Verify the end-to-end flow: 2bbbbb7
    - [x] Connect/disconnect a display (if possible) and check menu updates. 2bbbbb7
    - [x] Switch display via menu and confirm Timer Beam moves. 2bbbbb7
    - [x] Restart app and confirm display selection persists. 2bbbbb7
- [x] Task: Conductor - User Manual Verification 'Phase 4' (Protocol in workflow.md) 2bbbbb7
