# Specification: Launch at Login Support

## Overview
This track implements "Launch at Login" functionality for PixelScheduler. The goal is to ensure the app starts automatically when the user logs in, providing a seamless experience from the first run. The control for this feature will be located in the status bar menu.

## Functional Requirements
- **Automatic Enablement:** The "Launch at Login" feature must be enabled by default for new installations using `UserDefaults` registration.
- **Status Bar Menu Item:** A new menu item "Launch at Login" will be added to the status bar menu.
- **Toggle Behavior:** 
    - When clicked, it toggles the "Launch at Login" state.
    - A checkmark should appear next to the menu item when enabled.
- **System Integration:** Use the modern `SMAppService` API to register/unregister the app for login launch.
- **Persistence:** The user's preference must be persisted in `UserDefaults`.

## User Interface
- **Location:** Status bar menu.
- **Placement:** Between "Update Now" and the separator before "Exit".
- **Label:** "Launch at Login".
- **State Indicator:** Standard NSMenu checkmark.

## Technical Details
- **Technology:** `ServiceManagement.SMAppService`
- **Default State:** `true` (via `UserDefaults.register(defaults:)`)
- **Key:** `launchAtLogin` (String constant in `SettingsManager.Keys`)

## Acceptance Criteria
- [ ] On the first launch of the app, "Launch at Login" is enabled in the menu and registered with the system.
- [ ] Clicking "Launch at Login" in the menu toggles the checkmark.
- [ ] Clicking "Launch at Login" in the menu correctly registers/unregisters the app using `SMAppService`.
- [ ] The setting persists across app restarts.
