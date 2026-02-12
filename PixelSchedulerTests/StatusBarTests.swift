//
//  StatusBarTests.swift
//  PixelSchedulerTests
//
//  Created by Conductor on 2026/2/12.
//

import Testing
import AppKit
@testable import PixelScheduler

@MainActor
struct StatusBarTests {

    @Test func testStatusBarControllerInitialization() async throws {
        let manager = CalendarManager()
        let settings = SettingsManager()
        let controller = StatusBarController(calendarManager: manager, settingsManager: settings)
        #expect(controller.statusItem != nil)
    }

    @Test func testStatusItemHasMenu() async throws {
        let manager = CalendarManager()
        let settings = SettingsManager()
        let controller = StatusBarController(calendarManager: manager, settingsManager: settings)
        #expect(controller.statusItem.menu != nil)
    }
}
