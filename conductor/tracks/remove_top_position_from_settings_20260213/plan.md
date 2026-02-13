# Implementation Plan: Remove 'Top' Position from Settings UI

## Phase 1: UI Modification in SettingsView
- [x] Task: Modify `SettingsView.swift` to exclude the `.top` case from the position picker. 91c68ff
    - [x] Locate the `Picker` for beam position. 91c68ff
    - [x] Update the iteration or list of options to filter out `.top`. 91c68ff
- [x] Task: Verify that if `SettingsManager` has `.top` stored, the picker either shows no selection or gracefully handles the hidden state. 91c68ff
- [x] Task: Conductor - User Manual Verification 'Phase 1' (Protocol in workflow.md) 91c68ff

## Phase 2: Regression Testing and Final Verification
- [x] Task: Run all unit and UI tests to ensure removing the option from the UI did not break any underlying logic. 91c68ff
- [x] Task: Manually verify that setting the position to "top" via `UserDefaults` still works (simulating a legacy user). 91c68ff
- [x] Task: Conductor - User Manual Verification 'Phase 2' (Protocol in workflow.md) 91c68ff
