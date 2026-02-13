# Technology Stack

## Core Language & Runtime
- **Swift 6:** Leveraging the latest language features, including strict concurrency safety for reliable data fetching and UI updates.

## UI Frameworks
- **SwiftUI:** Used for modern, declarative UI development of the Preferences/Settings window and potentially the Beam UI components.
- **AppKit:** Essential for low-level macOS system integration, including the `NSStatusItem` (menu bar), `NSPanel`/`NSWindow` management for the "Timer Beam," and handling non-activating window behaviors.

## System Integrations
- **EventKit:** The primary framework for accessing and observing the macOS Calendar database and event changes.
- **UserDefaults:** For lightweight, persistent storage of user settings and configuration.
- **ServiceManagement (SMAppService):** To implement the "Launch at Login" functionality using modern macOS APIs.

## Architecture & Patterns
- **Concurrency:** Extensive use of Swift Concurrency (`async/await`, `MainActor`) to ensure data fetching doesn't block the UI.
- **Session-based State Management:** Decoupled transient "session" state from persistent storage to support real-time preview and transactional updates (Save/Cancel).
- **Visual Rendering:** Combination of SwiftUI `Canvas` or custom `NSView` drawing for the high-performance, transparent "Timer Beam."

## CI/CD & DevOps
- **GitHub Actions:** Automated build and release pipeline triggered by version tags.
- **xcodebuild:** Command-line tool for building the Xcode project in a headless environment.
- **hdiutil & zip:** Standard macOS and Unix utilities for packaging artifacts (.dmg and .zip).
