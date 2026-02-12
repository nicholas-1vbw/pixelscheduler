# Track Specification: Core Timer Beam & Calendar Integration

## Overview
This track focuses on the foundational components of PixelScheduler: the transparent "Timer Beam" window and the integration with macOS Calendar via `EventKit`.

## Objectives
- Initialize the macOS application as a status bar utility.
- Request and handle Calendar access permissions.
- Fetch today's events from the user's calendars.
- Create a transparent, non-interactive `NSPanel` (the Timer Beam) that overlays on a screen edge.
- Implement basic rendering of event segments on the beam.

## Technical Requirements
- **Frameworks**: `AppKit`, `SwiftUI`, `EventKit`.
- **Window Management**: Use `NSPanel` with `.nonactivatingPanel` level and `.ignoresMouseEvents` to ensure it stays in the background and doesn't interfere with user interaction.
- **Data Fetching**: Use `EKEventStore` to fetch events from `00:00:00` to `23:59:59` of the current day.
- **UI Rendering**: A basic SwiftUI view or custom `NSView` to draw color-coded rectangles representing event durations.

## Dependencies
- Permission for `NSCalendarsUsageDescription` must be added to `Info.plist`.

## Success Criteria
- The app launches and appears in the menu bar.
- The user is prompted for calendar access.
- A visual bar appears on a screen edge (default to Top).
- The bar displays colored segments corresponding to existing calendar events.
