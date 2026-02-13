//
//  SettingsManagerLaunchAtLoginTests.swift
//  PixelSchedulerTests
//

import Testing
import Foundation
@testable import PixelScheduler

@MainActor
struct SettingsManagerLaunchAtLoginTests {

    @Test func testLaunchAtLoginDefaultValue() {
        let suiteName = "TestLaunchAtLoginDefault"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        
        let manager = SettingsManager(userDefaults: defaults)
        
        // This should fail initially because launchAtLogin is not yet implemented
        #expect(manager.launchAtLogin == true)
    }

    @Test func testLaunchAtLoginPersistence() {
        let suiteName = "TestLaunchAtLoginPersistence"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        
        var manager = SettingsManager(userDefaults: defaults)
        manager.launchAtLogin = false
        manager.save()
        
        let loadedManager = SettingsManager(userDefaults: defaults)
        #expect(loadedManager.launchAtLogin == false)
    }
}
