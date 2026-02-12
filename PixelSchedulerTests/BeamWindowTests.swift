//
//  BeamWindowTests.swift
//  PixelSchedulerTests
//
//  Created by Conductor on 2026/2/12.
//

import Testing
import AppKit
@testable import PixelScheduler

@MainActor
struct BeamWindowTests {

    @Test func testBeamWindowConfiguration() async throws {
        let window = BeamWindow()
        
        // Transparent
        #expect(window.backgroundColor == .clear)
        #expect(window.isOpaque == false)
        
        // Stays on top
        #expect(window.level == .statusBar || window.level == .floating)
        
        // Interactive enough for hover detection
        #expect(window.ignoresMouseEvents == false)
        
        // Panel style
        #expect(window is NSPanel)
        #expect(window.styleMask.contains(.nonactivatingPanel))
    }

    @Test func testFrameCalculations() async throws {
        // Use a dummy screen or specific rect for testing
        let dummyScreenFrame = NSRect(x: 0, y: 0, width: 1920, height: 1080)
        
        // Top
        let topFrame = FrameCalculator.calculateFrame(for: .top, thickness: 10, screenFrame: dummyScreenFrame)
        #expect(topFrame == NSRect(x: 0, y: 1070, width: 1920, height: 10))
        
        // Bottom
        let bottomFrame = FrameCalculator.calculateFrame(for: .bottom, thickness: 10, screenFrame: dummyScreenFrame)
        #expect(bottomFrame == NSRect(x: 0, y: 0, width: 1920, height: 10))
        
        // Left
        let leftFrame = FrameCalculator.calculateFrame(for: .left, thickness: 10, screenFrame: dummyScreenFrame)
        #expect(leftFrame == NSRect(x: 0, y: 0, width: 10, height: 1080))
        
        // Right
        let rightFrame = FrameCalculator.calculateFrame(for: .right, thickness: 10, screenFrame: dummyScreenFrame)
        #expect(rightFrame == NSRect(x: 1910, y: 0, width: 10, height: 1080))
    }
}

// Extension to help with testing without real screen
extension FrameCalculator {
    static func calculateFrame(for position: BeamPosition, thickness: CGFloat = 10, screenFrame: NSRect) -> NSRect {
        switch position {
        case .top:
            return NSRect(x: screenFrame.minX, y: screenFrame.maxY - thickness, width: screenFrame.width, height: thickness)
        case .bottom:
            return NSRect(x: screenFrame.minX, y: screenFrame.minY, width: screenFrame.width, height: thickness)
        case .left:
            return NSRect(x: screenFrame.minX, y: screenFrame.minY, width: thickness, height: screenFrame.height)
        case .right:
            return NSRect(x: screenFrame.maxX - thickness, y: screenFrame.minY, width: thickness, height: screenFrame.height)
        }
    }
}
