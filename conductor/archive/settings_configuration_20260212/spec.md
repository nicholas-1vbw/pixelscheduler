# Specification: Settings Window & Configuration

## Overview
This track implements a dedicated settings interface for PixelScheduler, allowing users to customize which calendars are displayed on the Timer Beam and configure the beam's physical appearance (position, thickness, and colors).

## Functional Requirements

### 1. Preferences Window
- Implement a standard macOS Preferences Window (accessible via the Status Bar menu).
- **Layout:** All settings must be displayed on a single, clean page without tabs or sidebars, as the number of configuration options is currently limited.

### 2. Calendar Management
- **Hierarchical List:** Display available calendars grouped by source (e.g., iCloud, Google, Work).
- **Selection:** Users can enable/disable individual calendars via checkboxes.
- **Group Actions:** Include "Select All" and "Deselect All" options for each calendar group.

### 3. Beam Configuration
- **Position:** Choose the screen edge for the beam (Top, Bottom, Left, Right) using a segmented control or edge icons.
- **Thickness:** Adjust the beam's width/height using a slider with a numeric pixel display.
- **Color Selection:**
    - Provide independent color controls for the **Beam Base Color** and the **Indicator Color** (the marker showing current time).
    - For both colors, provide:
        - **Presets:** A small selection of curated color swatches.
        - **Manual Hex Input:** A text field for hex codes (e.g., `#FFFFFF`).

### 4. Settings Persistence
- Store all configuration values in `UserDefaults`.
- **Explicit Save:** Changes made in the settings window are only applied to the active Timer Beam when the user clicks a "Save" or "Apply" button.

## Non-Functional Requirements
- **Consistency:** Follow macOS Human Interface Guidelines for preference windows.
- **Performance:** Ensure the calendar list fetches data efficiently without blocking the UI.

## Acceptance Criteria
- Clicking "Settings" in the status bar opens the Preferences window.
- The calendar list correctly reflects the user's system calendars.
- Changing settings and clicking "Save" immediately updates both the beam appearance and the indicator color.
- Settings persist after the application is restarted.

## Out of Scope
- Per-calendar color overrides (the beam will use a single base color or existing event colors for now).
- Multiple beam support (only one beam at a time).
