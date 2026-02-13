# Product Guidelines

## Visual & Interface Design
- **Tone:** Minimalist & Utility-First. The interface should feel like a native extension of macOS, using standard system fonts (San Francisco) and design patterns.
- **The "Timer Beam":** 
    - Default style is **Native & Adaptive**, using colors derived from the user's calendars with a subtle transparency to blend with the desktop background.
    - **User Customization:** Users must have the ability to override the default styles and configure their own visual preferences for the beam (e.g., custom colors, thickness).
- **Status Bar Icon:** Should be a standard macOS template image that adapts to light and dark modes.

## User Experience (UX)
- **Ambient Awareness:** The beam is designed for passive observation. Interaction (like popovers) should be fast and non-disruptive.
- **Non-Interaction by Default:** The beam window should typically be transparent to mouse clicks (`.ignoresMouseEvents`) unless the user is specifically hovering for details (if that feature is enabled).
- **Persistence:** All settings and the user's preferred screen edge must be saved and restored across application restarts.

## Privacy & Permissions
- **Transparency:** Use standard macOS authorization prompts with a clear `NSCalendarsUsageDescription`.
- **Graceful Failure:** If calendar access is denied, the application should not crash. It should display a clear but non-intrusive message or a "placeholder" beam state that explains why no data is visible.

## Technical & Performance
- **Efficiency:** Prioritize low energy impact. Calendar data fetching should be throttled (every 5-15 minutes), and the current time indicator should update no more than once per minute by default.
- **Robustness:** Handle potential `EventKit` errors and edge cases (e.g., midnight transitions, system sleep/wake) reliably.
- **Hardware Awareness:** Gracefully handle display configuration changes (resolution changes, monitor connections/disconnections) by repositioning the beam bar according to user preferences.
