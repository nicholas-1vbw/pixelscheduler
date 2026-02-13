# Manual Verification Protocol: Event Popup Alignment

## Test Case 1: Left Beam Alignment
1. Open PixelScheduler Settings.
2. Set Beam Position to **Left**.
3. Ensure there is at least one event in the current time range.
4. Hover over an event segment on the left beam.
5. **Observation:** Note the vertical position of the popover relative to the event segment.
6. **Expected (Fix):** The vertical center of the popover should align with the vertical center of the event segment.

## Test Case 2: Right Beam Alignment
1. Open PixelScheduler Settings.
2. Set Beam Position to **Right**.
3. Hover over an event segment on the right beam.
4. **Observation:** Note the vertical position of the popover relative to the event segment.
5. **Expected (Fix):** The vertical center of the popover should align with the vertical center of the event segment.

## Test Case 3: Edge Clamping (Top)
1. Set Beam Position to **Left** or **Right**.
2. Find or create an event very close to the top of the screen.
3. Hover over it.
4. **Observation:** Does the popover extend above the screen edge or get cut off?
5. **Expected (Fix):** The popover should be clamped so its top edge is within the screen bounds.

## Test Case 4: Edge Clamping (Bottom)
1. Set Beam Position to **Left** or **Right**.
2. Find or create an event very close to the bottom of the screen.
3. Hover over it.
4. **Observation:** Does the popover extend below the screen edge or get cut off?
5. **Expected (Fix):** The popover should be clamped so its bottom edge is within the screen bounds.

## Test Case 5: Regression - Top/Bottom Beams
1. Set Beam Position to **Top** then **Bottom**.
2. Hover over events.
3. **Expected:** Horizontal alignment and clamping should remain correct as before.
