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
        
        // Use the name of the last available screen to test matching (likely different from main if multiple)
        if let targetScreen = NSScreen.screens.last {
            manager.selectedDisplayName = targetScreen.localizedName
            let resolvedScreen = manager.resolveSelectedScreen()
            #expect(resolvedScreen?.localizedName == targetScreen.localizedName)
        }
    }

    @MainActor
    @Test func testBeamWindowUsesSelectedScreen() {
        let manager = SettingsManager(userDefaults: UserDefaults(suiteName: "TestBeamWindowScreen")!)
        if NSScreen.screens.count > 1, let secondScreen = NSScreen.screens.last {
            manager.selectedDisplayName = secondScreen.localizedName
            let window = BeamWindow(settings: manager)
            
            #expect(window.frame.intersects(secondScreen.frame))
            #expect(!window.frame.intersects(NSScreen.screens[0].frame))
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
