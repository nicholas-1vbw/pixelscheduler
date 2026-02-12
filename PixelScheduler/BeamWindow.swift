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
            contentRect: NSRect(x: 0, y: 0, width: 800, height: 10), // Initial placeholder size
            styleMask: [.nonactivatingPanel, .borderless],
            backing: .buffered,
            defer: false
        )
        
        self.isOpaque = false
        self.backgroundColor = .clear
        self.level = .statusBar
        self.ignoresMouseEvents = true
        self.collectionBehavior = [.canJoinAllSpaces, .stationary]
        self.hasShadow = false
        
        // Ensure the window can be seen
        self.orderFrontRegardless()
    }
}
