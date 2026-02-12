# Specification: LivePreview for Settings

## Overview
This track implements a "LivePreview" feature for the PixelScheduler settings. Instead of a static or separate preview, the actual Timer Beam on the screen will reflect settings changes in real-time as they are adjusted in the Settings window. These changes are temporary and will only be persisted to disk if the user explicitly clicks a "Save" button.

## Functional Requirements
- **Real-time Beam Updates:** The `BeamView` must update immediately (Live) when settings such as color, thickness, edge position, or event visibility are modified in the `SettingsView`.
- **State Management:**
    - The application must maintain a "Session State" representing the current adjustments and a "Persistent State" representing the last saved configuration.
    - Upon opening the Settings window, the current persistent state is captured as a backup.
- **Persistence:**
    - A **"Save" button** will commit the "Session State" to the persistent storage (`UserDefaults`).
    - A **"Cancel" button** will discard the "Session State" and restore the beam to the backup state.
- **Automatic Restoration:** The beam must restore to the backup state if:
    - The Settings window is closed without clicking "Save".
    - The application is quit while the Settings window is open with unsaved changes.

## Non-Functional Requirements
- **Performance:** Real-time updates to the beam should be fluid and not cause UI lag in the settings window.
- **Consistency:** The actual beam must always accurately reflect the sliders and toggles currently visible in the Settings UI.

## Acceptance Criteria
- [ ] Modifying any setting in the Settings window results in an immediate visual change on the actual screen-edge Timer Beam.
- [ ] Clicking "Save" persists the changes across application restarts.
- [ ] Clicking "Cancel" reverts the beam to the state it was in before the Settings window was opened.
- [ ] Closing the Settings window via the red "X" button reverts the beam to the previous saved state if "Save" was not clicked.
- [ ] Quitting the app while settings are unsaved does not result in those changes being persisted.

## Out of Scope
- Separate "Preview Window" or "Miniature Beam" within the settings UI.
- Undo/Redo history for individual setting changes (only Save/Cancel for the entire session).
