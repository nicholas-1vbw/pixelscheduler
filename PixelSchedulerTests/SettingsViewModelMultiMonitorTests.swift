//
//  SettingsViewModelMultiMonitorTests.swift
//  PixelSchedulerTests
//

import Testing
import Foundation
import AppKit
@testable import PixelScheduler

@MainActor
struct SettingsViewModelMultiMonitorTests {

    @Test func testInitialSelectedDisplayName() {
        let suiteName = "TestViewModelMultiMonitorInit"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        let manager = SettingsManager(userDefaults: defaults)
        manager.selectedDisplayName = "External Monitor"
        
        let viewModel = SettingsViewModel(settingsManager: manager, calendarManager: CalendarManager(store: MockEventStore()))
        
        #expect(viewModel.selectedDisplayName == "External Monitor")
    }

    @Test func testSelectedDisplayNameUpdatesManager() {
        let suiteName = "TestViewModelMultiMonitorUpdate"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        let manager = SettingsManager(userDefaults: defaults)
        let viewModel = SettingsViewModel(settingsManager: manager, calendarManager: CalendarManager(store: MockEventStore()))
        
        viewModel.selectedDisplayName = "New Monitor"
        
        #expect(manager.selectedDisplayName == "New Monitor")
    }

    @Test func testAvailableScreensIsNotEmpty() {
        let manager = SettingsManager(userDefaults: UserDefaults(suiteName: "TestAvailableScreens")!)
        let viewModel = SettingsViewModel(settingsManager: manager, calendarManager: CalendarManager(store: MockEventStore()))
        
        // At least the main screen should be present
        #expect(!viewModel.availableScreens.isEmpty)
        #expect(viewModel.availableScreens.contains(NSScreen.main?.localizedName ?? ""))
    }
}
