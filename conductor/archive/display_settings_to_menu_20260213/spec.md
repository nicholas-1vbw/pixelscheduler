# Specification: Display Settings to Menu Transition

## Overview
This track involves moving the display selection functionality from the main Settings window to a dedicated submenu in the macOS Status Bar (Menu Bar). The goal is to improve accessibility and allow users to switch the Timer Beam between displays more efficiently.

## Functional Requirements
- **Status Bar Integration:** Add a "Display" submenu to the existing Status Bar menu.
- **Dynamic Display Listing:** The submenu must dynamically list all currently connected displays.
- **Active Display Indication:** The currently active display for the Timer Beam must be indicated with a checkmark in the submenu.
- **Immediate Switching:** Selecting a display from the submenu must immediately relocate the Timer Beam to that display.
- **Persistence:** Display selection changes made via the menu must be persisted to `UserDefaults` using the existing settings management logic.
- **Settings UI Cleanup:** Remove the display selection controls (e.g., Picker or similar) from the `SettingsView`.

## Non-Functional Requirements
- **Responsiveness:** The menu should update its list of available displays when displays are connected or disconnected (leveraging existing `NSScreen` notifications if not already present).
- **Consistency:** The selection in the menu must stay in sync with the internal `SettingsManager` state.

## Acceptance Criteria
1. The Status Bar menu contains a "Display" submenu.
2. All connected displays are listed as items in the "Display" submenu.
3. The display currently hosting the Timer Beam has a checkmark next to its name in the menu.
4. Clicking a different display in the menu moves the Timer Beam to that display instantly.
5. The display selection is no longer visible in the main Settings window.
6. The selected display remains active after restarting the application.

## Out of Scope
- Adding advanced multi-display features like "Show on all displays" or per-display customization beyond selection.
- Redesigning the entire Status Bar menu layout.
