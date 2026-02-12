# Implementation Plan: UI Enhancements - Time Indicator & Event Popovers

This plan outlines the steps to implement the current time indicator and interactive event popovers for the PixelScheduler Timer Beam.

## Phase 1: Current Time Indicator [checkpoint: pending]
- [x] Task: Logic for Time-to-Position Mapping
    - [x] Write unit tests to verify the calculation of the 0.0 - 1.0 position based on seconds since midnight.
    - [x] Implement a helper method to provide the current fractional position of the day.
- [x] Task: Rendering the "Now" Indicator
    - [x] Write unit tests (or view snapshots) to verify the indicator shape's placement relative to the beam.
    - [x] Implement the indicator shape (Triangle/Circle) in `BeamView`.
    - [x] Ensure the indicator respects the beam's orientation (Top, Bottom, Left, Right).
- [x] Task: Real-time Updates
    - [x] Implement a timer or use SwiftUI's `TimelineView` to refresh the indicator position every minute.
    - [x] Verify that the indicator moves correctly without manual app refresh.
- [x] Task: Conductor - User Manual Verification 'Phase 1: Current Time Indicator' (Protocol in workflow.md)

## Phase 2: Interactivity & Mouse Tracking [checkpoint: pending]
- [x] Task: Mouse Hover Detection
    - [x] Update `BeamWindow` or `BeamView` to enable mouse tracking/hover events.
    - [x] Write unit tests to verify that the correct event model is identified based on mouse coordinates.
    - [x] Implement a mechanism to track which event (if any) is currently under the cursor.
- [x] Task: Custom Popover UI
    - [x] Implement a SwiftUI view for the popover containing: Title, Time Range, Duration, and Calendar Info.
    - [x] Apply modern macOS styling (translucency, rounded corners).
- [x] Task: Popover Integration & Behavior
    - [x] Connect the hover state to the display of the SwiftUI `.popover`.
    - [x] Verify the popover appears on hover and disappears when the mouse leaves the segment.
- [x] Task: Conductor - User Manual Verification 'Phase 2: Interactivity & Mouse Tracking' (Protocol in workflow.md)
