//
//  SettingsViewModel.swift
//  PixelScheduler
//

import Foundation
import SwiftUI
import Combine
import EventKit

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var beamPosition: BeamPosition
    @Published var beamThickness: Double
    @Published var beamBaseColorHex: String
    @Published var indicatorColorHex: String
    @Published var selectedCalendarIDs: Set<String>
    @Published var groupedCalendars: [CalendarGroup] = []
    
    private let settingsManager: SettingsManager
    private let calendarManager: CalendarManager
    
    init(settingsManager: SettingsManager, calendarManager: CalendarManager) {
        self.settingsManager = settingsManager
        self.calendarManager = calendarManager
        
        self.beamPosition = settingsManager.beamPosition
        self.beamThickness = settingsManager.beamThickness
        self.beamBaseColorHex = settingsManager.beamBaseColorHex
        self.indicatorColorHex = settingsManager.indicatorColorHex
        self.selectedCalendarIDs = settingsManager.selectedCalendarIDs
        
        self.groupedCalendars = calendarManager.fetchGroupedCalendars()
    }
    
    func toggleCalendar(_ id: String) {
        if selectedCalendarIDs.contains(id) {
            selectedCalendarIDs.remove(id)
        } else {
            selectedCalendarIDs.insert(id)
        }
    }
    
    func isGroupSelected(_ group: CalendarGroup) -> Bool {
        let allIDs = Set(group.calendars.map { $0.calendarIdentifier })
        return !allIDs.isEmpty && allIDs.isSubset(of: selectedCalendarIDs)
    }
    
    func toggleGroup(_ group: CalendarGroup) {
        let allIDs = Set(group.calendars.map { $0.calendarIdentifier })
        if isGroupSelected(group) {
            selectedCalendarIDs.subtract(allIDs)
        } else {
            selectedCalendarIDs.formUnion(allIDs)
        }
    }
    
    func save() {
        settingsManager.beamPosition = beamPosition
        settingsManager.beamThickness = beamThickness
        settingsManager.beamBaseColorHex = beamBaseColorHex
        settingsManager.indicatorColorHex = indicatorColorHex
        settingsManager.selectedCalendarIDs = selectedCalendarIDs
    }
}
