# Implementation Plan: Launch at Login Support

## Phase 1: Foundation and Persistence [checkpoint: eef732d]
- [x] Task: **Add `launchAtLogin` key and property to `SettingsManager`** e0f119c
    - [ ] Define `Keys.launchAtLogin = "launchAtLogin"` in `SettingsManager.swift`.
    - [ ] Add a `@Published var launchAtLogin: Bool` property.
    - [ ] Implement `registerDefaults` in `SettingsManager` to set `launchAtLogin` to `true`.
    - [ ] Update `init` to load the value from `UserDefaults`.
    - [ ] Update `save`, `beginSession`, and `revertSession` to include `launchAtLogin`.
- [x] Task: **Write Unit Tests for `SettingsManager` login launch logic** e0f119c
    - [ ] Verify default value is `true`.
    - [ ] Verify value persists and reverts correctly in a session.
- [x] Task: Conductor - User Manual Verification 'Phase 1: Foundation and Persistence' (Protocol in workflow.md) eef732d

## Phase 2: System Integration (SMAppService)
- [ ] Task: **Implement login launch registration logic**
    - [ ] Create a helper method in `SettingsManager` (or a dedicated service) that uses `SMAppService.mainApp` to register or unregister based on the `launchAtLogin` state.
    - [ ] Ensure this logic is called whenever `launchAtLogin` is updated and at app startup to sync the system state with the setting.
- [ ] Task: **Write Unit Tests for registration logic**
    - [ ] Mock or verify (where possible) the interaction with `SMAppService`.
- [ ] Task: Conductor - User Manual Verification 'Phase 2: System Integration (SMAppService)' (Protocol in workflow.md)

## Phase 3: UI Implementation
- [ ] Task: **Update `StatusBarController` to include the toggle**
    - [ ] Add the "Launch at Login" `NSMenuItem` in `setupMenu` between "Update Now" and the separator.
    - [ ] Implement the `@objc` action to toggle the setting via `SettingsManager`.
    - [ ] Ensure the menu item's checkmark state stays in sync with the `SettingsManager` value.
- [ ] Task: **Verify end-to-end functionality**
    - [ ] Manually verify the menu item exists and toggles correctly.
    - [ ] Verify the checkmark state persists after restarting the app.
- [ ] Task: Conductor - User Manual Verification 'Phase 3: UI Implementation' (Protocol in workflow.md)
