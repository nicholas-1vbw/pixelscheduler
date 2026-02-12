//
//  CalendarManagerTests.swift
//  PixelSchedulerTests
//
//  Created by Conductor on 2026/2/12.
//

import Testing
import EventKit
import SwiftUI
@testable import PixelScheduler

@MainActor
struct CalendarManagerTests {

    @Test func testRequestAccessSuccess() async throws {
        let mockStore = MockEventStore()
        mockStore.accessGranted = true
        let manager = CalendarManager(store: mockStore)
        
        let granted = try await manager.requestAccess()
        #expect(granted == true)
    }

    @Test func testFetchEvents() async throws {
        let mockStore = MockEventStore()
        let manager = CalendarManager(store: mockStore)
        
        let now = Date()
        manager.fetchEvents(for: now)
        
        let events = manager.events
        #expect(events.count == 2)
        #expect(events[0].title == "Event 1")
        #expect(events[1].title == "Event 2")
    }

    @Test func testEventTransformation() async throws {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // Create events manually without relying on EKEventStore for logic
        let store = EKEventStore()
        let event = EKEvent(eventStore: store)
        event.title = "Test Event"
        event.startDate = today.addingTimeInterval(12 * 3600)
        event.endDate = event.startDate.addingTimeInterval(3600)
        
        let transformed = CalendarManager.transform(ekEvents: [event], for: today)
        
        #expect(transformed.count == 1)
        let timelineEvent = transformed[0]
        #expect(timelineEvent.title == "Test Event")
        #expect(abs(timelineEvent.startOffset - 0.5) < 0.001)
        #expect(abs(timelineEvent.durationWidth - (1.0/24.0)) < 0.001)
    }
}

// Mocking infrastructure
@MainActor
class MockEventStore: EventStoreProtocol {
    var accessGranted = false
    
    func requestAccess() async throws -> Bool {
        return accessGranted
    }
    
    func events(matching predicate: NSPredicate) -> [EKEvent] {
        let store = EKEventStore()
        let event1 = EKEvent(eventStore: store)
        event1.title = "Event 1"
        event1.startDate = Date()
        event1.endDate = Date().addingTimeInterval(3600)
        
        let event2 = EKEvent(eventStore: store)
        event2.title = "Event 2"
        event2.startDate = Date().addingTimeInterval(7200)
        event2.endDate = Date().addingTimeInterval(10800)
        
        return [event1, event2]
    }
    
    func predicateForEvents(withStart start: Date, end: Date, calendars: [EKCalendar]?) -> NSPredicate {
        return NSPredicate(value: true)
    }
}
