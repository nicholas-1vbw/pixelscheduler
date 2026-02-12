//
//  BeamView.swift
//  PixelScheduler
//
//  Created by Conductor on 2026/2/12.
//

import SwiftUI

struct BeamView: View {
    let events: [TimelineEvent]
    let position: BeamPosition
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background bar (very faint)
                Color.black.opacity(0.1)
                
                // Event segments
                ForEach(events) { event in
                    segment(for: event, in: geometry.size)
                }
                
                // "Now" indicator (just a placeholder for now)
                nowIndicator(in: geometry.size)
            }
        }
    }
    
    @ViewBuilder
    private func segment(for event: TimelineEvent, in size: CGSize) -> some View {
        let isVertical = position == .left || position == .right
        
        if isVertical {
            Rectangle()
                .fill(event.color)
                .frame(width: size.width, height: size.height * event.durationWidth)
                .offset(y: size.height * event.startOffset)
        } else {
            Rectangle()
                .fill(event.color)
                .frame(width: size.width * event.durationWidth, height: size.height)
                .offset(x: size.width * event.startOffset)
        }
    }
    
    @ViewBuilder
    private func nowIndicator(in size: CGSize) -> some View {
        // Placeholder for current time indicator
        Rectangle()
            .fill(Color.white)
            .frame(width: 2, height: size.height) // Horizontal beam
            // Logic to position based on current time will come later
    }
}

#Preview {
    BeamView(events: [
        TimelineEvent(id: "1", title: "Test", startOffset: 0.1, durationWidth: 0.05, color: .blue),
        TimelineEvent(id: "2", title: "Meeting", startOffset: 0.5, durationWidth: 0.1, color: .red)
    ], position: .top)
    .frame(width: 800, height: 20)
}
