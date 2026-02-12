# Implementation Plan: Settings Window & Configuration

## Phase 1: Settings Data & Persistence Foundation
- [x] Task: Create `SettingsManager` to handle persistence via `UserDefaults` (70b89f4)
    - [x] Define `SettingsManager` with properties for `beamPosition`, `beamThickness`, `beamBaseColor`, `indicatorColor`, and `selectedCalendarIDs`.
    - [x] Implement `save()` and `load()` methods.
- [x] Task: Write Tests for `SettingsManager` (70b89f4)
    - [x] Verify that default values are correctly initialized.
    - [x] Verify that values persist and retrieve correctly from `UserDefaults`.
- [x] Task: Implement `SettingsManager` (70b89f4)
- [x] Task: Conductor - User Manual Verification 'Phase 1: Settings Data & Persistence Foundation' (Protocol in workflow.md) (70b89f4)

## Phase 2: Settings UI - Layout & Appearance Controls
- [x] Task: Create `SettingsView` (SwiftUI) with a single-page layout (71702)
    - [x] Implement Section for **Beam Appearance**.
    - [x] Add Segmented Control for **Position** (Top, Bottom, Left, Right).
    - [x] Add Slider for **Thickness** (1px to 50px) with numeric display.
    - [x] Add Color controls for **Base Color** and **Indicator Color** (Presets + Hex Input).
- [x] Task: Write Tests for `SettingsView` (UI Tests or Unit Tests for View State) (71702)
    - [x] Verify that controls update the draft state in the view.
- [x] Task: Implement Appearance Controls in `SettingsView` (71702)
- [x] Task: Add "Save" and "Cancel" buttons with explicit save logic (71702)
- [ ] Task: Conductor - User Manual Verification 'Phase 2: Settings UI - Layout & Appearance Controls' (Protocol in workflow.md)

## Phase 3: Settings UI - Calendar Management
- [x] Task: Update `CalendarManager` to provide grouped calendar data (73475)
    - [x] Implement a method to fetch calendars grouped by source.
- [x] Task: Implement Calendar List in `SettingsView` (73475)
    - [x] Create a hierarchical list with checkboxes.
    - [x] Implement "Select All/None" logic for each group.
- [x] Task: Write Tests for Calendar Selection logic (73475)
    - [x] Verify that group toggle correctly updates all sub-calendars.
- [x] Task: Implement Calendar Selection in `SettingsView` (73475)
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Settings UI - Calendar Management' (Protocol in workflow.md)

## Phase 4: Integration & System Behavior
- [ ] Task: Update `StatusBarController` to manage the Settings Window
    - [ ] Implement `openSettings()` to show the `SettingsView` in a standard `NSWindow`.
- [ ] Task: Update `CalendarManager` to filter events
    - [ ] Modify event fetching logic to only include events from `selectedCalendarIDs`.
- [ ] Task: Update `BeamWindow` and `BeamView` to reflect settings
    - [ ] Listen for settings changes (or update on Save) to reposition and restyle the beam.
- [ ] Task: Write Integration Tests
    - [ ] Verify that clicking "Save" in Settings triggers a refresh in the Beam UI.
- [ ] Task: Implement Integration Logic
- [ ] Task: Conductor - User Manual Verification 'Phase 4: Integration & System Behavior' (Protocol in workflow.md)
