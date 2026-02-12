//
//  EventModels.swift
//  PixelScheduler
//
//  Created by Conductor on 2026/2/12.
//

import Foundation
import SwiftUI
import EventKit

struct TimelineEvent: Identifiable, Sendable {
    let id: String
    let title: String
    let startOffset: Double // 0.0 to 1.0
    let durationWidth: Double // 0.0 to 1.0
    let color: Color
}

extension CalendarManager {
    @MainActor
    static func transform(ekEvents: [EKEvent], for day: Date) -> [TimelineEvent] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: day)
        let totalSeconds: Double = 24 * 60 * 60
        
        return ekEvents.compactMap { ekEvent in
            let start = ekEvent.startDate ?? day
            let end = ekEvent.endDate ?? day
            
            let startDiff = start.timeIntervalSince(startOfDay)
            let duration = end.timeIntervalSince(start)
            
            // Map to 0...1 range
            let startOffset = max(0, min(1, startDiff / totalSeconds))
            let durationWidth = max(0, min(1 - startOffset, duration / totalSeconds))
            
            // Fallback color logic
            let nsColor = ekEvent.calendar?.color ?? .systemBlue
            let color = Color(nsColor: nsColor)
            
            return TimelineEvent(
                id: ekEvent.eventIdentifier ?? UUID().uuidString,
                title: ekEvent.title ?? "Untitled Event",
                startOffset: startOffset,
                durationWidth: durationWidth,
                color: color
            )
        }
    }
}
