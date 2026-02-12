# Implementation Plan: Core Timer Beam & Calendar Integration

This plan outlines the steps to implement the core "Timer Beam" window and basic calendar event fetching for PixelScheduler.

## Phase 1: Foundation & Permissions [checkpoint: 40d90a9]
- [x] Task: Project Initialization & Status Bar Setup [commit: 201753c]
    - [x] Write unit tests to verify app delegate / lifecycle initialization and status item creation.
    - [x] Implement the status bar icon and basic menu (Exit, Manual Refresh).
- [x] Task: Calendar Access & Permissions [commit: 8d2f82f]
    - [x] Update `Info.plist` with `NSCalendarsUsageDescription`.
    - [x] Write unit tests to verify the permission handling logic (mocking `EKEventStore`).
    - [x] Implement the `CalendarManager` to request access and handle the authorization status.
- [x] Task: Conductor - User Manual Verification 'Phase 1: Foundation & Permissions' (Protocol in workflow.md)

## Phase 2: Data Fetching Layer
- [x] Task: Event Fetching Logic [commit: 374902a]
    - [x] Write unit tests for fetching events for a specific day and filtering by calendar (using mock data).
    - [x] Implement the `fetchEvents(for day: Date)` method in `CalendarManager`.
- [x] Task: Event Data Transformation [commit: 91b1a59]
    - [x] Write unit tests for mapping `EKEvent` data to a simplified internal `Event` model suitable for UI rendering.
    - [x] Implement the transformation logic, including mapping 24 hours to a 0.0 - 1.0 range.
- [ ] Task: Conductor - User Manual Verification 'Phase 2: Data Fetching Layer' (Protocol in workflow.md)

## Phase 3: The Timer Beam UI
- [ ] Task: Transparent Overlay Window
    - [ ] Write unit tests to verify the configuration of the `NSPanel` (transparent, non-interactive, stays on top).
    - [ ] Implement the `BeamWindow` using `NSPanel`.
- [ ] Task: Beam Positioning & Orientation
    - [ ] Write unit tests for calculating window frame based on screen edge (Top, Bottom, Left, Right).
    - [ ] Implement window positioning logic based on user settings (default to Top).
- [ ] Task: Conductor - User Manual Verification 'Phase 3: The Timer Beam UI' (Protocol in workflow.md)

## Phase 4: Rendering & Visualization
- [ ] Task: Basic Beam Rendering
    - [ ] Write unit tests to verify the drawing logic for event segments (correct offsets and widths).
    - [ ] Implement the `BeamView` (SwiftUI or custom `NSView`) to render event segments on the window.
- [ ] Task: Conductor - User Manual Verification 'Phase 4: Rendering & Visualization' (Protocol in workflow.md)
