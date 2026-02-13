# Specification: Multi-Monitor Support

## Overview
This track adds support for choosing which display the Timer Beam should be rendered on. Users with multiple monitors will be able to select their preferred display from the Settings window.

## Functional Requirements
- **Display Selection UI:**
    - Add a "Display" picker to the `SettingsView`.
    - The picker should list all currently connected monitors by their localized names (e.g., "Built-in Retina Display", "Dell U2720Q").
- **Display Targeting:**
    - The `BeamWindow` must move to the selected display immediately when changed (utilizing the LivePreview mechanism).
    - Only one display can be targeted at a time.
- **Persistence:**
    - The selected display's name must be saved in `UserDefaults`.
- **Fallback Logic:**
    - If the saved display name is not found among the currently connected monitors (e.g., monitor was disconnected), the application must fallback to the system's primary display (`NSScreen.main`).
- **Dynamic Updates:**
    - The display list in Settings should update automatically if monitors are added or removed while the window is open.
    - The `BeamWindow` should reposition itself if the screen configuration changes (e.g., resolution change or display disconnection).

## Non-Functional Requirements
- **Robustness:** Handle cases where multiple monitors might share the same name by defaulting to the first available match.

## Acceptance Criteria
- [ ] Settings window shows a list of all connected displays.
- [ ] Changing the display selection immediately moves the Timer Beam to that monitor.
- [ ] Disconnecting the selected monitor causes the beam to reappear on the main display.
- [ ] Reconnecting the selected monitor causes the beam to move back to it (if the name matches).
- [ ] The selection persists across app restarts.

## Out of Scope
- Displaying the beam on multiple monitors simultaneously.
- Drag-and-drop display selection.
