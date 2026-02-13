# Implementation Plan: Remove 'Top' Position from Settings UI

## Phase 1: UI Modification in SettingsView
- [ ] Task: Modify `SettingsView.swift` to exclude the `.top` case from the position picker.
    - [ ] Locate the `Picker` for beam position.
    - [ ] Update the iteration or list of options to filter out `.top`.
- [ ] Task: Verify that if `SettingsManager` has `.top` stored, the picker either shows no selection or gracefully handles the hidden state.
- [ ] Task: Conductor - User Manual Verification 'Phase 1' (Protocol in workflow.md)

## Phase 2: Regression Testing and Final Verification
- [ ] Task: Run all unit and UI tests to ensure removing the option from the UI did not break any underlying logic.
- [ ] Task: Manually verify that setting the position to "top" via `UserDefaults` still works (simulating a legacy user).
- [ ] Task: Conductor - User Manual Verification 'Phase 2' (Protocol in workflow.md)
