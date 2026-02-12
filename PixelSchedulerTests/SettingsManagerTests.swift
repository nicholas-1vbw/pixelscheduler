//
//  SettingsManagerTests.swift
//  PixelSchedulerTests
//
//  Created by Conductor on 2026/2/12.
//

import Testing
import Foundation
import SwiftUI
@testable import PixelScheduler

@MainActor
struct SettingsManagerTests {

    @Test func testDefaultValues() {
        let manager = SettingsManager(userDefaults: UserDefaults(suiteName: "TestDefaults")!)
        
        #expect(manager.beamPosition == .top)
        #expect(manager.beamThickness == 10.0)
        #expect(manager.beamBaseColorHex == "#000000")
        #expect(manager.indicatorColorHex == "#FF0000")
        #expect(manager.selectedCalendarIDs.isEmpty)
    }

    @Test func testPersistence() {
        let suiteName = "TestPersistence"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        
        var manager = SettingsManager(userDefaults: defaults)
        
        manager.beamPosition = .bottom
        manager.beamThickness = 20.0
        manager.beamBaseColorHex = "#123456"
        manager.indicatorColorHex = "#654321"
        manager.selectedCalendarIDs = ["cal1", "cal2"]
        
        manager.save()
        
        // Load in a new instance
        let loadedManager = SettingsManager(userDefaults: defaults)
        
        #expect(loadedManager.beamPosition == .bottom)
        #expect(loadedManager.beamThickness == 20.0)
        #expect(loadedManager.beamBaseColorHex == "#123456")
        #expect(loadedManager.indicatorColorHex == "#654321")
        #expect(loadedManager.selectedCalendarIDs.contains("cal1"))
        #expect(loadedManager.selectedCalendarIDs.contains("cal2"))
        #expect(loadedManager.selectedCalendarIDs.count == 2)
    }
}
