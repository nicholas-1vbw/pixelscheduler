//
//  CalendarManager.swift
//  PixelScheduler
//

import Foundation
import EventKit
import Combine

struct CalendarGroup: Identifiable {
    let id: String
    let sourceName: String
    let calendars: [EKCalendar]
}

@MainActor
class CalendarManager: ObservableObject {
    private let eventStore: EventStoreProtocol
    @Published var events: [TimelineEvent] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(store: EventStoreProtocol = EKEventStore()) {
        self.eventStore = store
        setupSystemCalendarListener()
    }
    
    private func setupSystemCalendarListener() {
        NotificationCenter.default.publisher(for: .EKEventStoreChanged)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.fetchEvents()
            }
            .store(in: &cancellables)
    }
    
    func requestAccess() async throws -> Bool {
        return try await eventStore.requestAccess()
    }
    
    func fetchGroupedCalendars() -> [CalendarGroup] {
        let calendars = eventStore.calendars(for: .event)
        let grouped = Dictionary(grouping: calendars) { $0.source.title }
        
        return grouped.map { (sourceName, calendars) in
            CalendarGroup(id: sourceName, sourceName: sourceName, calendars: calendars.sorted(by: { $0.title < $1.title }))
        }.sorted(by: { $0.sourceName < $1.sourceName })
    }
    
    func fetchEvents(for day: Date = Date(), calendarIDs: Set<String>? = nil) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: day)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let ekCalendars: [EKCalendar]?
        if let ids = calendarIDs, !ids.isEmpty {
            let allCalendars = eventStore.calendars(for: .event)
            ekCalendars = allCalendars.filter { ids.contains($0.calendarIdentifier) }
        } else {
            ekCalendars = nil
        }
        
        let predicate = eventStore.predicateForEvents(withStart: startOfDay, end: endOfDay, calendars: ekCalendars)
        let ekEvents = eventStore.events(matching: predicate)
        
        self.events = Self.transform(ekEvents: ekEvents, for: day)
    }

    static func dayProgress(at date: Date = Date()) -> Double {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let secondsSinceMidnight = date.timeIntervalSince(startOfDay)
        let totalSecondsInDay: Double = 24 * 60 * 60
        return max(0, min(1, secondsSinceMidnight / totalSecondsInDay))
    }
}

protocol EventStoreProtocol {
    func requestAccess() async throws -> Bool
    func events(matching predicate: NSPredicate) -> [EKEvent]
    func predicateForEvents(withStart start: Date, end: Date, calendars: [EKCalendar]?) -> NSPredicate
    func calendars(for entityType: EKEntityType) -> [EKCalendar]
}

extension EKEventStore: EventStoreProtocol {
    func requestAccess() async throws -> Bool {
        if #available(macOS 14.0, *) {
            return try await requestFullAccessToEvents()
        } else {
            return try await requestAccess(to: .event)
        }
    }
    
    func calendars(for entityType: EKEntityType) -> [EKCalendar] {
        return self.calendars(for: entityType)
    }
}
