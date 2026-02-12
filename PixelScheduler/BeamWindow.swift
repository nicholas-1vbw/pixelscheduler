//
//  BeamWindow.swift
//  PixelScheduler
//
//  Created by Conductor on 2026/2/12.
//

import AppKit
import SwiftUI

class BeamWindow: NSPanel {
    init(events: [TimelineEvent] = [], position: BeamPosition = .top) {
        super.init(
            contentRect: NSRect(x: 0, y: 0, width: 800, height: 20),
            styleMask: [.nonactivatingPanel, .borderless],
            backing: .buffered,
            defer: false
        )
        
        self.isOpaque = false
        self.backgroundColor = .clear // Back to clear, child view will provide color
        self.level = .statusBar
        self.ignoresMouseEvents = false // Enable mouse events for hover detection
        self.collectionBehavior = [.canJoinAllSpaces, .stationary]
        self.hasShadow = false
        
        update(events: events, position: position)
        self.orderFrontRegardless()
    }
    
    func update(events: [TimelineEvent], position: BeamPosition) {
        let beamView = BeamView(events: events, position: position)
        let hostingView = NSHostingView(rootView: beamView)
        hostingView.frame = self.contentView?.bounds ?? .zero
        self.contentView = hostingView
        
        if let mainScreen = NSScreen.main {
            let frame = FrameCalculator.calculateFrame(for: position, thickness: 10, screen: mainScreen)
            self.setFrame(frame, display: true)
        }
    }
}
