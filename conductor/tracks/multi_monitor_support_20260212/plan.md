# Implementation Plan: Multi-Monitor Support

This plan outlines the steps to allow users to choose which display the Timer Beam should be rendered on, with automatic fallback and real-time updates.

## Phase 1: Data Model & Persistence [checkpoint: 170458d]

Goal: Update the settings infrastructure to support saving and resolving display selections.

- [x] Task: Update `SettingsManager` to include `selectedDisplayName` (defaulting to empty). 70ca230
    - [x] Task: Implement `resolveSelectedScreen()` in `SettingsManager` (or a utility) that returns the `NSScreen` matching the saved name, falling back to `NSScreen.main`. bee8829
- [x] Task: Update `SettingsManager.Snapshot` and session logic to include `selectedDisplayName`. 2e3ca10
- [x] Task: Conductor - User Manual Verification 'Phase 1: Data Model & Persistence' (Protocol in workflow.md) 170458d

## Phase 2: Settings UI Integration
Goal: Provide a user interface to select the desired display.

- [x] Task: Update `SettingsViewModel` to publish a list of currently connected screen names. 4ca096c
- [~] Task: Add a "Display" picker to `SettingsView` using the available screen names.
- [ ] Task: Ensure the picker updates `SettingsManager` in real-time to trigger LivePreview repositioning.
- [~] Task: Conductor - User Manual Verification 'Phase 2: Settings UI Integration' (Protocol in workflow.md)

## Phase 3: Window Repositioning & Screen Lifecycle
Goal: Ensure the Timer Beam correctly identifies and moves to the selected display, and reacts to hardware changes.

- [x] Task: Update `BeamWindow.update` and `FrameCalculator.calculateFrame` to explicitly use the `NSScreen` resolved from settings instead of defaulting to `.main`. cd4e1ca
- [x] Task: In `AppDelegate`, subscribe to `NSApplication.didChangeScreenParametersNotification` to re-fetch events and reposition the beam if the monitor configuration changes. 8d96c5f
- [~] Task: Verify that the beam falls back to the main display if the selected display is disconnected.
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Window Repositioning & Screen Lifecycle' (Protocol in workflow.md)
