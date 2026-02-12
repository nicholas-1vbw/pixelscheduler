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

    @Test func testRequestAccessFailure() async throws {
        let mockStore = MockEventStore()
        mockStore.accessGranted = false
        let manager = CalendarManager(store: mockStore)
        let granted = try await manager.requestAccess()
        #expect(granted == false)
    }
}

// Mocking infrastructure
class MockEventStore: EventStoreProtocol {
    var accessGranted = false
    
    func requestAccess() async throws -> Bool {
        return accessGranted
    }
}
