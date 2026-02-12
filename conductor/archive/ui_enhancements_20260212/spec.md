# Track Specification: UI Enhancements - Time Indicator & Event Popovers

## Overview
This track enhances the "Timer Beam" UI by adding a real-time progress indicator and providing detailed context for calendar events through interactive, custom-styled popovers.

## Objectives
- Implement a visual indicator (e.g., a small triangle or circle) that marks the current time on the 24-hour beam.
- Add interactivity to event segments: hovering over a segment should trigger a detailed information popup.
- Ensure the UI remains lightweight and non-intrusive, adhering to the project's "ambient" vision.

## Functional Requirements
- **Current Time Indicator**:
    - A distinct shape (triangle/circle) positioned on or adjacent to the beam.
    - Moves automatically as time progresses (refreshes at least once per minute).
    - Position is calculated as `(current_seconds_since_midnight / 86400)`.
- **Event Popovers**:
    - Triggered by mouse hover over any rendered event segment.
    - Implemented as a custom SwiftUI popover with a modern macOS aesthetic.
    - **Data to Display**:
        - Event Title
        - Time Range (e.g., 14:00 - 15:30)
        - Duration (e.g., 1h 30m)
        - Calendar Source (Name and Color)
- **Interactive Behavior**:
    - The popover should appear near the cursor or the segment being hovered.
    - It should disappear immediately when the mouse leaves the segment.

## Technical Requirements
- **Frameworks**: SwiftUI (for the popover and indicator rendering), AppKit (for window-level mouse tracking).
- **Positioning**: The indicator must correctly respond to the beam's orientation (Top, Bottom, Left, Right).
- **Concurrency**: Use a timer or `TimelineView` to update the "Now" indicator without excessive CPU usage.

## Acceptance Criteria
- A shape accurately marking the current time is visible on the beam.
- Hovering over an event segment displays a popover with all required details.
- The popover is styled using SwiftUI to match a modern macOS look.
- Moving the mouse away from an event hides the popover.

## Out of Scope
- Direct event editing or deletion from the popover.
- Integration with third-party calendar services (stays within EventKit).
