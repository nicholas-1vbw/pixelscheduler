//
//  BeamView.swift
//  PixelScheduler
//
//  Created by Conductor on 2026/2/12.
//

import SwiftUI
import Combine

struct BeamView: View {
    let events: [TimelineEvent]
    @ObservedObject var settings: SettingsManager
    @State private var currentProgress: Double = CalendarManager.dayProgress()
    @State private var hoveredEvent: TimelineEvent? = nil
    
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background bar
                Color(hex: settings.beamBaseColorHex).opacity(0.3)
                
                // Event segments
                ForEach(events) { event in
                    EventSegmentView(
                        event: event,
                        position: settings.beamPosition,
                        containerSize: geometry.size,
                        hoveredEvent: $hoveredEvent
                    )
                }
                
                // "Now" indicator
                nowIndicator(in: geometry.size)
            }
        }
        .onReceive(timer) { _ in
            currentProgress = CalendarManager.dayProgress()
        }
    }
    
    @ViewBuilder
    private func nowIndicator(in size: CGSize) -> some View {
        let isVertical = settings.beamPosition == .left || settings.beamPosition == .right
        let indicatorSize: CGFloat = 8
        let progress = currentProgress
        
        if isVertical {
            NowIndicatorShape(position: settings.beamPosition)
                .fill(Color(hex: settings.indicatorColorHex))
                .shadow(radius: 1)
                .frame(width: size.width, height: indicatorSize)
                .position(x: size.width / 2, y: clamp(size.height * progress, min: 4, max: size.height - 4))
        } else {
            NowIndicatorShape(position: settings.beamPosition)
                .fill(Color(hex: settings.indicatorColorHex))
                .shadow(radius: 1)
                .frame(width: indicatorSize, height: size.height)
                .position(x: clamp(size.width * progress, min: 4, max: size.width - 4), y: size.height / 2)
        }
    }

    private func clamp(_ value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
        Swift.min(Swift.max(value, min), max)
    }
}

struct EventSegmentView: View {
    let event: TimelineEvent
    let position: BeamPosition
    let containerSize: CGSize
    @Binding var hoveredEvent: TimelineEvent?
    
    var body: some View {
        let isVertical = position == .left || position == .right
        
        Rectangle()
            .fill(event.color)
            .frame(
                width: isVertical ? containerSize.width : containerSize.width * event.durationWidth,
                height: isVertical ? containerSize.height * event.durationWidth : containerSize.height
            )
            .onHover { hovering in
                if hovering {
                    hoveredEvent = event
                } else if hoveredEvent?.id == event.id {
                    hoveredEvent = nil
                }
            }
            .popover(item: Binding(
                get: { hoveredEvent?.id == event.id ? event : nil },
                set: { if $0 == nil && hoveredEvent?.id == event.id { hoveredEvent = nil } }
            ), attachmentAnchor: .rect(.bounds), arrowEdge: popoverArrowEdge) { event in
                EventPopoverView(event: event)
            }
            .position(
                x: isVertical ? containerSize.width / 2 : containerSize.width * (event.startOffset + event.durationWidth / 2),
                y: isVertical ? containerSize.height * (event.startOffset + event.durationWidth / 2) : containerSize.height / 2
            )
    }
    
    private var popoverArrowEdge: Edge {
        switch position {
        case .top: return .bottom
        case .bottom: return .top
        case .left: return .trailing
        case .right: return .leading
        }
    }
}

struct EventPopoverView: View {
    let event: TimelineEvent
    
    private var timeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return "\(formatter.string(from: event.startDate)) - \(formatter.string(from: event.endDate))"
    }
    
    private var durationString: String {
        let duration = event.endDate.timeIntervalSince(event.startDate)
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(event.title)
                .font(.headline)
            
            Text(timeString)
                .font(.subheadline)
            
            HStack {
                Text(durationString)
                Spacer()
                HStack(spacing: 4) {
                    Circle()
                        .fill(event.color)
                        .frame(width: 8, height: 8)
                    Text(event.calendarName)
                }
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(12)
        .frame(width: 200)
    }
}

struct NowIndicatorShape: Shape {
    let position: BeamPosition
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        switch position {
        case .top:
            path.move(to: CGPoint(x: rect.midX - 4, y: 0))
            path.addLine(to: CGPoint(x: rect.midX + 4, y: 0))
            path.addLine(to: CGPoint(x: rect.midX, y: 8))
            path.closeSubpath()
        case .bottom:
            path.move(to: CGPoint(x: rect.midX - 4, y: rect.height))
            path.addLine(to: CGPoint(x: rect.midX + 4, y: rect.height))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.height - 8))
            path.closeSubpath()
        case .left:
            path.move(to: CGPoint(x: 0, y: rect.midY - 4))
            path.addLine(to: CGPoint(x: 0, y: rect.midY + 4))
            path.addLine(to: CGPoint(x: 8, y: rect.midY))
            path.closeSubpath()
        case .right:
            path.move(to: CGPoint(x: rect.width, y: rect.midY - 4))
            path.addLine(to: CGPoint(x: rect.width, y: rect.midY + 4))
            path.addLine(to: CGPoint(x: rect.width - 8, y: rect.midY))
            path.closeSubpath()
        }
        
        return path
    }
}

#Preview {
    let now = Date()
    BeamView(events: [
        TimelineEvent(id: "1", title: "Test Event", startDate: now, endDate: now.addingTimeInterval(1800), startOffset: 0.1, durationWidth: 0.05, color: .blue, calendarName: "Work"),
        TimelineEvent(id: "2", title: "Meeting", startDate: now.addingTimeInterval(3600), endDate: now.addingTimeInterval(7200), startOffset: 0.5, durationWidth: 0.1, color: .red, calendarName: "Personal")
    ], settings: SettingsManager(userDefaults: .standard))
    .frame(width: 800, height: 20)
}
