# Implementation Plan: UI Enhancements - Time Indicator & Event Popovers

This plan outlines the steps to implement the current time indicator and interactive event popovers for the PixelScheduler Timer Beam.

## Phase 1: Current Time Indicator [checkpoint: pending]
- [ ] Task: Logic for Time-to-Position Mapping
    - [ ] Write unit tests to verify the calculation of the 0.0 - 1.0 position based on seconds since midnight.
    - [ ] Implement a helper method to provide the current fractional position of the day.
- [ ] Task: Rendering the "Now" Indicator
    - [ ] Write unit tests (or view snapshots) to verify the indicator shape's placement relative to the beam.
    - [ ] Implement the indicator shape (Triangle/Circle) in `BeamView`.
    - [ ] Ensure the indicator respects the beam's orientation (Top, Bottom, Left, Right).
- [ ] Task: Real-time Updates
    - [ ] Implement a timer or use SwiftUI's `TimelineView` to refresh the indicator position every minute.
    - [ ] Verify that the indicator moves correctly without manual app refresh.
- [ ] Task: Conductor - User Manual Verification 'Phase 1: Current Time Indicator' (Protocol in workflow.md)

## Phase 2: Interactivity & Mouse Tracking [checkpoint: pending]
- [ ] Task: Mouse Hover Detection
    - [ ] Update `BeamWindow` or `BeamView` to enable mouse tracking/hover events.
    - [ ] Write unit tests to verify that the correct event model is identified based on mouse coordinates.
    - [ ] Implement a mechanism to track which event (if any) is currently under the cursor.
- [ ] Task: Custom Popover UI
    - [ ] Implement a SwiftUI view for the popover containing: Title, Time Range, Duration, and Calendar Info.
    - [ ] Apply modern macOS styling (translucency, rounded corners).
- [ ] Task: Popover Integration & Behavior
    - [ ] Connect the hover state to the display of the SwiftUI `.popover`.
    - [ ] Verify the popover appears on hover and disappears when the mouse leaves the segment.
- [ ] Task: Conductor - User Manual Verification 'Phase 2: Interactivity & Mouse Tracking' (Protocol in workflow.md)
