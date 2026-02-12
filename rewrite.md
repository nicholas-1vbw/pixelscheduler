# Product Requirements Document: PixelScheduler Swift Rewrite

## 1. Project Overview
PixelScheduler is a macOS status bar utility that provides a visual "Timer Beam" on the screen edge to represent calendar events throughout the day. It acts as a non-intrusive, persistent schedule tracker.

## 2. Core Functionality

### 2.1 Calendar Integration
- **Data Source**: Access macOS Calendar via `EventKit`.
- **Event Fetching**: Retrieve all events for the current day (00:00 to 23:59).
- **Filtering**: Support selecting specific calendars to display (logic currently defaults to all event calendars).
- **Permissions**: Must handle runtime requests for Calendar access and provide a fallback/error state if denied.

### 2.2 The "Timer Beam" (Visual Interface)
- **Window Characteristics**:
    - Transparent, borderless window.
    - Floating above all other windows (`NSStatusWindowLevel` or `.statusBar`).
    - Non-interactive for mouse clicks (except for hover events if enabled).
- **Positions**: Support four screen edges: Top, Bottom, Left, Right.
- **Rendering Logic**:
    - **BackView**: A base background bar along the chosen edge.
    - **Event Segments**: Rectangles drawn over the bar, color-coded based on the source calendar's color.
    - **Current Time Tick**: A visual indicator (arrow or line) that moves according to the current system time.
- **Scaling**: Map 24 hours (86,400 seconds) to the screen's width (for Top/Bottom) or height (for Left/Right).
- **Interactions**:
    - **Popovers**: If enabled, hovering over an event segment displays a popover with the event title and time range.

### 2.3 Status Bar Menu
- **Icon**: A 16x16 / 32x32 template icon in the macOS menu bar.
- **Menu Items**:
    - **Update Now**: Manually trigger a refresh of calendar data.
    - **Settings...**: Open the Preferences window.
    - **Exit**: Terminate the application.

### 2.4 Preferences & Persistence
- **Configurable Settings**:
    - **Bar Position**: Top, Bottom, Left, Right.
    - **Bar Thickness**: Adjustable width/height of the beam.
    - **Update Interval**: Frequency of fetching new calendar data.
    - **Enable Popover**: Toggle for event detail tooltips.
    - **Launch at Login**: Toggle for automatic startup.
- **Persistence**: Save all settings using `UserDefaults`.

## 3. Technical Specifications (Swift Rewrite)

### 3.1 Recommended Frameworks
- **Language**: Swift 6
- **UI Framework**: SwiftUI (for Settings/Preferences), AppKit (for Status Bar and custom Beam Windows).
- **Data**: EventKit.
- **Concurrency**: Swift Concurrency (async/await) for data fetching.

### 3.2 Necessary Dependencies / Permissions
- **Frameworks**: `AppKit`, `SwiftUI`, `EventKit`, `ServiceManagement`.
- **Info.plist**:
    - `NSCalendarsUsageDescription`: "PixelScheduler needs access to your calendar to display events on the screen edge."
- **Sandbox Entitlements**:
    - `com.apple.security.personal-information.calendars`: Required for App Store / Sandboxed apps.

### 3.3 Implementation Details
- **Window Management**: Use `NSPanel` or `NSWindow` with `.nonactivatingPanel` and `.canJoinAllSpaces` collection behavior to ensure the beam stays visible across all Desktops/Mission Control.
- **Drawing**: Use SwiftUI `Canvas` or `ZStack` for the Beam UI, or a custom `NSView` with `draw(_:)` for high-performance rendering.
- **Launch at Login**: Use the modern `SMAppService.mainApp.register()` API (macOS 13+) instead of the deprecated `SMLoginItemSetEnabled`.
- **Single Instance**: Use `NSRunningApplication` check or `NSApplication`'s built-in behavior to prevent multiple instances from running.

## 4. Logical Flow
1. **Startup**: Check permissions -> Load Settings -> Setup Status Bar -> Initialize Timer Beam Window.
2. **Data Loop**: 
    - Fetch Events -> Calculate Pixel Offsets -> Update Beam UI.
    - Triggered on: Startup, Manual Refresh, and Timer Interval.
3. **Time Loop**:
    - Update "Tick" position every 10-60 seconds to reflect current time.
4. **Shutdown**: Save settings -> Close Windows -> Exit.

## 5. Visual Assets
- Status bar icons (Template images).
- App Icon.
- Triangle/Arrow assets for the Time Tick.
