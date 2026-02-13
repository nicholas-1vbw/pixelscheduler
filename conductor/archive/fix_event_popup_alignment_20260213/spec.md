# Specification: Event Popup Positioning Fix (Left/Right Beam)

## Overview
Currently, when the Timer Beam is positioned on the left or right edges of the screen, the event detail popups (popovers) may not be correctly aligned. This track aims to implement vertical centering for these popups relative to their respective event segments, mirroring the horizontal centering used for top/bottom positions. Additionally, clamping logic will be added to ensure popups remain fully visible on-screen.

## Functional Requirements
- **Vertical Centering:** For `left` and `right` beam positions, the event popup's vertical center must align with the vertical center of the event segment on the beam.
- **Edge Clamping:** If a vertically centered popup would extend beyond the top or bottom edge of the screen, it must be shifted vertically to stay within the visible screen area.
- **Horizontal Offset:** Maintain appropriate horizontal spacing from the beam so the popup does not overlap the beam itself.
- **Maintain Top/Bottom Logic:** Ensure that horizontal centering and clamping for `top` and `bottom` positions remain unaffected and correct.

## Non-Functional Requirements
- **Visual Consistency:** The transition/alignment should feel native and consistent with macOS UI patterns.
- **Accuracy:** The alignment must precisely reflect the event's position regardless of screen resolution or beam thickness.

## Acceptance Criteria
1. With the beam on the **Left**, hovering over an event shows a popup whose vertical center aligns with the event's vertical center.
2. With the beam on the **Right**, hovering over an event shows a popup whose vertical center aligns with the event's vertical center.
3. For events near the top or bottom of a side beam, the popup shifts vertically to remain fully visible without being cut off by the screen edge.
4. Existing correct behavior for **Top** and **Bottom** beam positions is preserved.

## Out of Scope
- Changing the content or styling of the event popup.
- Adding animations to the popup positioning.
