//
//  BeamWindow.swift
//  PixelScheduler
//
//  Created by Conductor on 2026/2/12.
//

import AppKit

class BeamWindow: NSPanel {
    init() {
        super.init(
            contentRect: NSRect(x: 0, y: 0, width: 800, height: 20), // More height for visibility
            styleMask: [.nonactivatingPanel, .borderless],
            backing: .buffered,
            defer: false
        )
        
        self.isOpaque = false
        self.backgroundColor = NSColor.red.withAlphaComponent(0.5) // Semi-transparent red
        self.level = .statusBar
        self.ignoresMouseEvents = true
        self.collectionBehavior = [.canJoinAllSpaces, .stationary]
        self.hasShadow = false
        
        // Initial positioning at the top of the main screen
        if let mainScreen = NSScreen.main {
            self.setFrame(FrameCalculator.calculateFrame(for: .top, thickness: 20, screen: mainScreen), display: true)
        }
        
        self.orderFrontRegardless()
    }
}
