# Implementation Plan: Settings Window & Configuration

## Phase 1: Settings Data & Persistence Foundation
- [ ] Task: Create `SettingsManager` to handle persistence via `UserDefaults`
    - [ ] Define `SettingsManager` with properties for `beamPosition`, `beamThickness`, `beamBaseColor`, `indicatorColor`, and `selectedCalendarIDs`.
    - [ ] Implement `save()` and `load()` methods.
- [ ] Task: Write Tests for `SettingsManager`
    - [ ] Verify that default values are correctly initialized.
    - [ ] Verify that values persist and retrieve correctly from `UserDefaults`.
- [ ] Task: Implement `SettingsManager`
- [ ] Task: Conductor - User Manual Verification 'Phase 1: Settings Data & Persistence Foundation' (Protocol in workflow.md)

## Phase 2: Settings UI - Layout & Appearance Controls
- [ ] Task: Create `SettingsView` (SwiftUI) with a single-page layout
    - [ ] Implement Section for **Beam Appearance**.
    - [ ] Add Segmented Control for **Position** (Top, Bottom, Left, Right).
    - [ ] Add Slider for **Thickness** (1px to 50px) with numeric display.
    - [ ] Add Color controls for **Base Color** and **Indicator Color** (Presets + Hex Input).
- [ ] Task: Write Tests for `SettingsView` (UI Tests or Unit Tests for View State)
    - [ ] Verify that controls update the draft state in the view.
- [ ] Task: Implement Appearance Controls in `SettingsView`
- [ ] Task: Add "Save" and "Cancel" buttons with explicit save logic
- [ ] Task: Conductor - User Manual Verification 'Phase 2: Settings UI - Layout & Appearance Controls' (Protocol in workflow.md)

## Phase 3: Settings UI - Calendar Management
- [ ] Task: Update `CalendarManager` to provide grouped calendar data
    - [ ] Implement a method to fetch calendars grouped by source.
- [ ] Task: Implement Calendar List in `SettingsView`
    - [ ] Create a hierarchical list with checkboxes.
    - [ ] Implement "Select All/None" logic for each group.
- [ ] Task: Write Tests for Calendar Selection logic
    - [ ] Verify that group toggle correctly updates all sub-calendars.
- [ ] Task: Implement Calendar Selection in `SettingsView`
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
