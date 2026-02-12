# Initial Concept
PixelScheduler is a macOS status bar utility that provides a visual "Timer Beam" on the screen edge to represent calendar events throughout the day, acting as a non-intrusive, persistent schedule tracker.

# Product Definition

## Vision
PixelScheduler aims to reduce the cognitive load of schedule management by providing a persistent, ambient visual indicator of time and upcoming events. Unlike traditional calendar apps or notifications that demand immediate attention, PixelScheduler sits at the edge of the user's focus, offering a glanceable summary of the day.

## Target Audience
- **Busy Professionals:** Individuals with dense schedules who need to stay aware of their next commitment without constantly checking a calendar.
- **Productivity Enthusiasts:** Users who prefer minimalist, system-integrated tools that provide high value with low distraction.
- **Students and Researchers:** People managing blocks of time for different tasks and desiring a visual representation of their progress through the day.

## Core Features
- **Ambient Timer Beam:** A customizable bar on any screen edge (Top, Bottom, Left, Right) that represents the 24-hour day.
- **Event Visualization:** Color-coded segments on the beam representing calendar events, fetched directly from macOS Calendar (EventKit).
- **Current Time Indicator:** A moving "tick" or marker that shows the present time relative to the day's events.
- **Interactive Popovers:** Hovering over event segments reveals details like title and duration, providing context without opening a full application.
- **Status Bar Control:** A lightweight menu bar icon for quick refreshes, access to settings, and exiting the app.
- **Deep macOS Integration:** Support for Launch at Login, multi-display/Mission Control visibility, and persistent settings via UserDefaults.

## Success Metrics
- **Non-Intrusiveness:** The app should feel like a native part of the macOS desktop experience.
- **Accuracy:** Event data and the time indicator must be perfectly synchronized with the system calendar and clock.
- **Performance:** Minimal CPU and memory footprint, ensuring the "Timer Beam" does not interfere with system responsiveness.
