//
//  BeamWindow.swift
//  PixelScheduler
//
//  Created by Conductor on 2026/2/12.
//

import AppKit
import SwiftUI

class BeamWindow: NSPanel {
    init(events: [TimelineEvent] = [], settings: SettingsManager) {
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
        
        update(events: events, settings: settings)
        self.orderFrontRegardless()
    }
    
    func update(events: [TimelineEvent], settings: SettingsManager) {
        let beamView = BeamView(events: events, settings: settings)
        let hostingView = NSHostingView(rootView: beamView)
        hostingView.frame = self.contentView?.bounds ?? .zero
        self.contentView = hostingView
        
        if let targetScreen = settings.resolveSelectedScreen() {
            let frame = FrameCalculator.calculateFrame(for: settings.beamPosition, thickness: CGFloat(settings.beamThickness), screen: targetScreen)
            self.setFrame(frame, display: true)
        }
    }
}
