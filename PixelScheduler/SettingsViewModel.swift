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
    @Published var beamPosition: BeamPosition {
        didSet { settingsManager.beamPosition = beamPosition }
    }
    @Published var beamThickness: Double {
        didSet { settingsManager.beamThickness = beamThickness }
    }
    @Published var beamBaseColorHex: String {
        didSet { settingsManager.beamBaseColorHex = beamBaseColorHex }
    }
    @Published var indicatorColorHex: String {
        didSet { settingsManager.indicatorColorHex = indicatorColorHex }
    }
    @Published var selectedCalendarIDs: Set<String> {
        didSet { settingsManager.selectedCalendarIDs = selectedCalendarIDs }
    }
    @Published var selectedDisplayName: String {
        didSet { settingsManager.selectedDisplayName = selectedDisplayName }
    }
    @Published var groupedCalendars: [CalendarGroup] = []
    @Published var availableScreens: [String] = []
    var isSaved = false
    
    private let settingsManager: SettingsManager
    private let calendarManager: CalendarManager
    private var cancellables = Set<AnyCancellable>()
    
    init(settingsManager: SettingsManager, calendarManager: CalendarManager) {
        self.settingsManager = settingsManager
        self.calendarManager = calendarManager
        
        self.beamPosition = settingsManager.beamPosition
        self.beamThickness = settingsManager.beamThickness
        self.beamBaseColorHex = settingsManager.beamBaseColorHex
        self.indicatorColorHex = settingsManager.indicatorColorHex
        self.selectedCalendarIDs = settingsManager.selectedCalendarIDs
        self.selectedDisplayName = settingsManager.selectedDisplayName
        
        self.groupedCalendars = calendarManager.fetchGroupedCalendars()
        self.updateAvailableScreens()
        
        // Start a session for LivePreview
        settingsManager.beginSession()
        
        // Observe screen changes
        NotificationCenter.default.publisher(for: NSApplication.didChangeScreenParametersNotification)
            .sink { [weak self] _ in
                Task { @MainActor in
                    self?.updateAvailableScreens()
                }
            }
            .store(in: &cancellables)
    }
    
    private func updateAvailableScreens() {
        availableScreens = NSScreen.screens.map { $0.localizedName }
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
        // Push final values to manager (already pushed by didSet, but good to be sure)
        settingsManager.beamPosition = beamPosition
        settingsManager.beamThickness = beamThickness
        settingsManager.beamBaseColorHex = beamBaseColorHex
        settingsManager.indicatorColorHex = indicatorColorHex
        settingsManager.selectedCalendarIDs = selectedCalendarIDs
        settingsManager.selectedDisplayName = selectedDisplayName
        
        // Persist to disk
        settingsManager.save()
        isSaved = true
    }
    
    func cancel() {
        settingsManager.revertSession()
        
        // Update own properties back to original state to reflect reversion in UI
        self.beamPosition = settingsManager.beamPosition
        self.beamThickness = settingsManager.beamThickness
        self.beamBaseColorHex = settingsManager.beamBaseColorHex
        self.indicatorColorHex = settingsManager.indicatorColorHex
        self.selectedCalendarIDs = settingsManager.selectedCalendarIDs
        self.selectedDisplayName = settingsManager.selectedDisplayName
    }
}
