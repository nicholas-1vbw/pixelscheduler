//
//  BeamPosition.swift
//  PixelScheduler
//
//  Created by Conductor on 2026/2/12.
//

import Foundation
import AppKit

enum BeamPosition: String, CaseIterable, Sendable {
    case top
    case bottom
    case left
    case right
}

struct FrameCalculator {
    static func calculateFrame(for position: BeamPosition, thickness: CGFloat = 10, screen: NSScreen = NSScreen.main!) -> NSRect {
        let screenFrame = screen.frame
        
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
