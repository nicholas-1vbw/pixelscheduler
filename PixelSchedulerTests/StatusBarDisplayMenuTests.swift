//
//  StatusBarDisplayMenuTests.swift
//  PixelSchedulerTests
//
import Testing
import AppKit
@testable import PixelScheduler

@MainActor
struct StatusBarDisplayMenuTests {

    @Test func testDisplaySubmenuExists() async throws {
        let manager = CalendarManager()
        let settings = SettingsManager(userDefaults: UserDefaults(suiteName: "TestDisplayMenu")!)
        let controller = StatusBarController(calendarManager: manager, settingsManager: settings)
        
        let menu = try #require(controller.statusItem.menu)
        let displayItem = menu.items.first { $0.title == "Display" }
        
        #expect(displayItem != nil, "Display menu item should exist")
        #expect(displayItem?.submenu != nil, "Display menu item should have a submenu")
    }

    @Test func testDisplaySubmenuItemsMatchScreens() async throws {
        let manager = CalendarManager()
        let settings = SettingsManager(userDefaults: UserDefaults(suiteName: "TestDisplayMenuItems")!)
        let controller = StatusBarController(calendarManager: manager, settingsManager: settings)
        
        let menu = try #require(controller.statusItem.menu)
        let displayItem = try #require(menu.items.first { $0.title == "Display" })
        let submenu = try #require(displayItem.submenu)
        
        let screens = NSScreen.screens
        #expect(submenu.items.count == screens.count, "Submenu should have an item for each screen")
        
        for screen in screens {
            let item = submenu.items.first { $0.title == screen.localizedName }
            #expect(item != nil, "Submenu should have an item for screen: \(screen.localizedName)")
        }
    }

    @Test func testSwitchDisplayUpdatesSettings() async throws {
        let manager = CalendarManager()
        let settings = SettingsManager(userDefaults: UserDefaults(suiteName: "TestSwitchDisplay")!)
        let controller = StatusBarController(calendarManager: manager, settingsManager: settings)
        
        let menu = try #require(controller.statusItem.menu)
        let displayItem = try #require(menu.items.first { $0.title == "Display" })
        let submenu = try #require(displayItem.submenu)
        
        let firstItem = try #require(submenu.items.first)
        let screen = try #require(firstItem.representedObject as? NSScreen)
        
        // Manually trigger the action
        controller.switchDisplay(firstItem)
        
        #expect(settings.selectedDisplayName == screen.localizedName)
        #expect(firstItem.state == .on)
    }
}
