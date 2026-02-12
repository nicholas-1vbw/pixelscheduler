//
//  SettingsManagerSessionTests.swift
//  PixelSchedulerTests
//
//  Created by Conductor on 2026/02/12.
//

import Testing
import Foundation
@testable import PixelScheduler

@MainActor
struct SettingsManagerSessionTests {

    @Test func testSnapshotAndRevert() async {
        let suiteName = "TestSnapshotRevert"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        
        let manager = SettingsManager(userDefaults: defaults)
        manager.beamPosition = .top
        manager.beamThickness = 10.0
        manager.save()
        
        // Take snapshot
        manager.beginSession()
        
        // Modify values
        manager.beamPosition = .bottom
        manager.beamThickness = 20.0
        
        #expect(manager.beamPosition == .bottom)
        #expect(manager.beamThickness == 20.0)
        
        // Revert
        manager.revertSession()
        
        #expect(manager.beamPosition == .top)
        #expect(manager.beamThickness == 10.0)
    }
    
    @Test func testManualSaveRequired() async {
        let suiteName = "TestManualSave"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        
        let manager = SettingsManager(userDefaults: defaults)
        manager.beamPosition = .top
        manager.save()
        
        // Modify value without calling save
        manager.beamPosition = .bottom
        
        // Create new instance to check persistence
        let newManager = SettingsManager(userDefaults: defaults)
        #expect(newManager.beamPosition == .top) // Should NOT have changed yet if we remove didSet { save() }
        
        manager.save()
        
        let savedManager = SettingsManager(userDefaults: defaults)
        #expect(savedManager.beamPosition == .bottom)
    }
}
