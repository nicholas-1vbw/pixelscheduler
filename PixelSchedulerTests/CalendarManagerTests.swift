//
//  CalendarManagerTests.swift
//  PixelSchedulerTests
//
//  Created by Conductor on 2026/2/12.
//

import Testing
import EventKit
@testable import PixelScheduler

struct CalendarManagerTests {

    @Test func testRequestAccessSuccess() async throws {
        let mockStore = MockEventStore()
        mockStore.accessGranted = true
        // CalendarManager should accept an injected store
        let manager = CalendarManager(store: mockStore)
        let granted = try await manager.requestAccess()
        #expect(granted == true)
    }

    @Test func testFetchEvents() async throws {
        let mockStore = MockEventStore()
        let manager = await CalendarManager(store: mockStore)
        
        let now = Date()
        await manager.fetchEvents(for: now)
        
        // MockStore returns 2 events by default
        let events = await manager.events
        #expect(events.count == 2)
        #expect(events[0].title == "Event 1")
        #expect(events[1].title == "Event 2")
    }
}

// Mocking infrastructure
class MockEventStore: EventStoreProtocol {
    var accessGranted = false
    
    func requestAccess() async throws -> Bool {
        return accessGranted
    }
    
    func events(matching predicate: NSPredicate) -> [EKEvent] {
        // Return some dummy events
        let event1 = EKEvent(eventStore: EKEventStore())
        event1.title = "Event 1"
        event1.startDate = Date()
        event1.endDate = Date().addingTimeInterval(3600)
        
        let event2 = EKEvent(eventStore: EKEventStore())
        event2.title = "Event 2"
        event2.startDate = Date().addingTimeInterval(7200)
        event2.endDate = Date().addingTimeInterval(10800)
        
        return [event1, event2]
    }
    
    func predicateForEvents(withStart start: Date, end: Date, calendars: [EKCalendar]?) -> NSPredicate {
        return NSPredicate(value: true)
    }
}
