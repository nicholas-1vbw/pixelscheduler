//
//  SettingsManagerDisplayTests.swift
//  PixelSchedulerTests
//
import Testing
import AppKit
@testable import PixelScheduler

@MainActor
struct SettingsManagerDisplayTests {

    @Test func testDisplayPersistence() async throws {
        let suiteName = "TestDisplayPersistence"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        
        var manager = SettingsManager(userDefaults: defaults)
        let testDisplayName = "Test Display"
        
        manager.selectedDisplayName = testDisplayName
        manager.save()
        
        let loadedManager = SettingsManager(userDefaults: defaults)
        #expect(loadedManager.selectedDisplayName == testDisplayName)
    }

    @Test func testResolveSelectedScreen() async throws {
        let suiteName = "TestResolveScreen"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        
        let manager = SettingsManager(userDefaults: defaults)
        
        // Test default fallback
        let defaultScreen = manager.resolveSelectedScreen()
        #expect(defaultScreen == NSScreen.main)
        
        // Test valid screen
        if let firstScreen = NSScreen.screens.first {
            manager.selectedDisplayName = firstScreen.localizedName
            #expect(manager.resolveSelectedScreen()?.localizedName == firstScreen.localizedName)
        }
        
        // Test invalid screen fallback
        manager.selectedDisplayName = "Non-existent Display"
        #expect(manager.resolveSelectedScreen() == NSScreen.main)
    }
}
