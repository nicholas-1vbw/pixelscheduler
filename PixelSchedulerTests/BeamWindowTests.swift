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
        
        // Non-interactive
        #expect(window.ignoresMouseEvents == true)
        
        // Panel style
        #expect(window is NSPanel)
        #expect(window.styleMask.contains(.nonactivatingPanel))
    }
}
