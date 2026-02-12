//
//  SettingsViewModelTests.swift
//  PixelSchedulerTests
//

import Testing
import Foundation
@testable import PixelScheduler

@MainActor
struct SettingsViewModelTests {

    @Test func testInitialStateFromManager() {
        let suiteName = "TestViewModelInit"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        let manager = SettingsManager(userDefaults: defaults)
        manager.beamPosition = .bottom
        manager.beamThickness = 15.0
        
        let viewModel = SettingsViewModel(settingsManager: manager)
        
        #expect(viewModel.beamPosition == .bottom)
        #expect(viewModel.beamThickness == 15.0)
    }

    @Test func testSaveToManager() {
        let suiteName = "TestViewModelSave"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        let manager = SettingsManager(userDefaults: defaults)
        let viewModel = SettingsViewModel(settingsManager: manager)
        
        viewModel.beamPosition = .right
        viewModel.beamThickness = 25.0
        
        // Before save, manager should still have old values
        #expect(manager.beamPosition == .top) // default
        
        viewModel.save()
        
        #expect(manager.beamPosition == .right)
        #expect(manager.beamThickness == 25.0)
    }
}
