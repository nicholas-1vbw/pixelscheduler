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
        let controller = StatusBarController(calendarManager: manager)
        #expect(controller.statusItem != nil)
    }

    @Test func testStatusItemHasMenu() async throws {
        let manager = CalendarManager()
        let controller = StatusBarController(calendarManager: manager)
        #expect(controller.statusItem.menu != nil)
    }
}
