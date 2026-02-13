# Implementation Plan: Event Popup Positioning Fix

## Phase 1: Infrastructure and Visual Verification Setup [checkpoint: a9dc219]
- [x] Task: Create a dedicated manual verification protocol to capture the "before" state of popover positioning on Left/Right beams. 18f1f74
- [x] Task: Review `TimelineEvent` and `EventSegmentView` to ensure coordinate calculations for vertical beams are robust. f127d8c
- [ ] Task: Conductor - User Manual Verification 'Phase 1' (Protocol in workflow.md)

## Phase 2: Implement Vertical Centering and Alignment [checkpoint: 5da97e8]
- [x] Task: Update `EventSegmentView` to use `attachmentAnchor` and `arrowEdge` parameters in the `.popover` modifier. 37029eb
    - [x] For `left` position: Set `attachmentAnchor` to `.rect(.center)` and `arrowEdge` to `.trailing`.
    - [x] For `right` position: Set `attachmentAnchor` to `.rect(.center)` and `arrowEdge` to `.leading`.
- [x] Task: Verify that SwiftUI's native popover logic handles clamping or implement a custom positioning logic if native behavior is insufficient for "center-aligned clamping". 37029eb
- [x] Task: Conductor - User Manual Verification 'Phase 2' (Protocol in workflow.md) 37029eb

## Phase 3: Regression Testing and Cleanup [checkpoint: a0b8ab6]
- [x] Task: Ensure Top/Bottom popover positioning remains correct (centered horizontally). 37029eb
- [x] Task: Verify behavior near screen corners (Top-Left, Top-Right, etc.). 37029eb
- [x] Task: Conductor - User Manual Verification 'Phase 3' (Protocol in workflow.md) 37029eb
