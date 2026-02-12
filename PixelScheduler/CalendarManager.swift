//
//  CalendarManager.swift
//  PixelScheduler
//

import Foundation
import EventKit
import Combine

@MainActor
class CalendarManager: ObservableObject {
    private let eventStore: EventStoreProtocol
    @Published var events: [TimelineEvent] = []
    
    init(store: EventStoreProtocol = EKEventStore()) {
        self.eventStore = store
    }
    
    func requestAccess() async throws -> Bool {
        return try await eventStore.requestAccess()
    }
    
    func fetchEvents(for day: Date = Date()) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: day)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let predicate = eventStore.predicateForEvents(withStart: startOfDay, end: endOfDay, calendars: nil)
        let ekEvents = eventStore.events(matching: predicate)
        
        self.events = Self.transform(ekEvents: ekEvents, for: day)
    }
}

protocol EventStoreProtocol {
    func requestAccess() async throws -> Bool
    func events(matching predicate: NSPredicate) -> [EKEvent]
    func predicateForEvents(withStart start: Date, end: Date, calendars: [EKCalendar]?) -> NSPredicate
}

extension EKEventStore: EventStoreProtocol {
    func requestAccess() async throws -> Bool {
        if #available(macOS 14.0, *) {
            return try await requestFullAccessToEvents()
        } else {
            return try await requestAccess(to: .event)
        }
    }
}
