# PixelScheduler

PixelScheduler is a minimalist macOS status bar utility that provides an ambient, persistent visual "Timer Beam" at the edge of your screen. It represents your calendar events throughout the day, helping you stay aware of your schedule without the distraction of traditional calendar apps.

![PixelScheduler Icon](PixelScheduler/Assets.xcassets/AppIcon.appiconset/Contents.json) *(Icon placeholder)*

## Features

- **Ambient Timer Beam:** A customizable bar on any screen edge representing a 24-hour day.
- **Event Visualization:** Color-coded segments synced directly with your macOS Calendar (EventKit).
- **Interactive Popovers:** Hover over any event segment to see its title, duration, and calendar details.
- **Current Time Indicator:** A subtle marker showing your progress through the day.
- **Multi-Monitor Support:** Choose which display should host the Timer Beam via the status bar menu.
- **Live Preview Settings:** See changes to thickness and colors in real-time as you adjust them.
- **Privacy First:** Only requests access to your calendars; data never leaves your device.

## Usage

1.  **Launch the App:** Once opened, a calendar icon will appear in your macOS menu bar.
2.  **Grant Permissions:** PixelScheduler will request access to your calendars to display events.
3.  **Configure:** Click the menu bar icon and select **Settings...** to customize:
    -   **Position:** Place the beam on the Bottom, Left, or Right edge of your screen.
    -   **Thickness:** Adjust the width/height of the beam.
    -   **Colors:** Customize the base beam and time indicator colors.
    -   **Calendars:** Choose which calendars to display.
4.  **Display Selection:** Use the **Display** submenu in the menu bar to move the beam to a different monitor.

## Advanced Configuration

While the Settings UI offers the safest positioning options, advanced users can manually configure the beam position using the macOS `defaults` command.

### Activating the "Top" Position

The "Top" position is hidden by default in the Settings UI to prevent overlap with the macOS menu bar. If you have a custom setup or want to enable it anyway, run the following command in Terminal:

```bash
# Set position to Top
defaults write com.github.nicholas-1vbw.PixelScheduler beamPosition top

# Restart the app for changes to take effect
```

### Other Position Options

You can also set other positions via Terminal:

```bash
# Valid options: top, bottom, left, right
defaults write com.github.nicholas-1vbw.PixelScheduler beamPosition bottom
defaults write com.github.nicholas-1vbw.PixelScheduler beamPosition left
defaults write com.github.nicholas-1vbw.PixelScheduler beamPosition right
```

### Adjusting Thickness

```bash
# Set thickness to 15 pixels
defaults write com.github.nicholas-1vbw.PixelScheduler beamThickness -float 15.0
```

## Installation

-   Requires macOS 14.0 or later.
-   Built with Swift 6 and SwiftUI.

## Development

To build the project locally:

1.  Clone the repository.
2.  Open `PixelScheduler.xcodeproj` in Xcode 15 or later.
3.  Build and run the `PixelScheduler` scheme.

## License

[Insert License Information Here]
