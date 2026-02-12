//
//  StatusBarTests.swift
//  PixelSchedulerTests
//
//  Created by Conductor on 2026/2/12.
//

import Testing
import AppKit
@testable import PixelScheduler

struct StatusBarTests {

    @Test func testStatusBarControllerInitialization() async throws {
        // This test expects a StatusBarController class to exist.
        // It should initialize an NSStatusItem.
        let controller = StatusBarController()
        #expect(controller.statusItem != nil)
    }

    @Test func testStatusItemHasMenu() async throws {
        let controller = StatusBarController()
        #expect(controller.statusItem.menu != nil)
    }
}
