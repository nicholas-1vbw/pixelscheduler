//
//  SettingsManagerMultiMonitorTests.swift
//  PixelSchedulerTests
//

import Testing
import Foundation
import SwiftUI
@testable import PixelScheduler

@MainActor
struct SettingsManagerMultiMonitorTests {

    @Test func testSelectedDisplayNameDefaultValue() {
        let suiteName = "TestMultiMonitorDefaults"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        
        let manager = SettingsManager(userDefaults: defaults)
        
        #expect(manager.selectedDisplayName == "")
    }

    @Test func testSelectedDisplayNamePersistence() {
        let suiteName = "TestMultiMonitorPersistence"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        
        var manager = SettingsManager(userDefaults: defaults)
        manager.selectedDisplayName = "External Monitor"
        manager.save()
        
        let loadedManager = SettingsManager(userDefaults: defaults)
        #expect(loadedManager.selectedDisplayName == "External Monitor")
    }
}
