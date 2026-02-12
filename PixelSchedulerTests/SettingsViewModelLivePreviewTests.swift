//
//  SettingsViewModelLivePreviewTests.swift
//  PixelSchedulerTests
//

import Testing
import Foundation
@testable import PixelScheduler

@MainActor
struct SettingsViewModelLivePreviewTests {

    @Test func testLiveUpdatesToManager() {
        let suiteName = "TestViewModelLive"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        let manager = SettingsManager(userDefaults: defaults)
        let viewModel = SettingsViewModel(settingsManager: manager, calendarManager: CalendarManager(store: MockEventStore()))
        
        // Initial state
        #expect(manager.beamPosition == .top)
        
        // Change position in VM
        viewModel.beamPosition = .bottom
        
        // Manager should update immediately for LivePreview
        #expect(manager.beamPosition == .bottom)
        
        // But UserDefaults should NOT have it yet
        let freshManager = SettingsManager(userDefaults: defaults)
        #expect(freshManager.beamPosition == .top)
    }
    
    @Test func testCancelRevertsManager() {
        let suiteName = "TestViewModelCancel"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        let manager = SettingsManager(userDefaults: defaults)
        manager.beamPosition = .top
        manager.save()
        
        let viewModel = SettingsViewModel(settingsManager: manager, calendarManager: CalendarManager(store: MockEventStore()))
        
        viewModel.beamPosition = .bottom
        #expect(manager.beamPosition == .bottom)
        
        viewModel.cancel()
        
        #expect(manager.beamPosition == .top)
    }
}
