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
        
        let manager = SettingsManager(userDefaults: defaults)
        manager.selectedDisplayName = "External Monitor"
        manager.save()
        
        let loadedManager = SettingsManager(userDefaults: defaults)
        #expect(loadedManager.selectedDisplayName == "External Monitor")
    }

    @Test func testResolveSelectedScreenFallback() {
        let manager = SettingsManager(userDefaults: UserDefaults(suiteName: "TestFallback")!)
        manager.selectedDisplayName = "Non-existent Screen"
        
        let resolvedScreen = manager.resolveSelectedScreen()
        #expect(resolvedScreen == NSScreen.main)
    }

    @Test func testResolveSelectedScreenMatch() {
        let manager = SettingsManager(userDefaults: UserDefaults(suiteName: "TestMatch")!)
        
        // Use the name of the first available screen to test matching
        if let firstScreen = NSScreen.screens.first {
            manager.selectedDisplayName = firstScreen.localizedName
            let resolvedScreen = manager.resolveSelectedScreen()
            #expect(resolvedScreen?.localizedName == firstScreen.localizedName)
        }
    }

    @Test func testSessionRevertForSelectedDisplayName() {
        let manager = SettingsManager(userDefaults: UserDefaults(suiteName: "TestSessionRevert")!)
        manager.selectedDisplayName = "Initial Display"
        
        manager.beginSession()
        manager.selectedDisplayName = "Changed Display"
        #expect(manager.selectedDisplayName == "Changed Display")
        
        manager.revertSession()
        #expect(manager.selectedDisplayName == "Initial Display")
    }
}
