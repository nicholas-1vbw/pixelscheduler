//
//  PixelSchedulerUITests.swift
//  PixelSchedulerUITests
//

import XCTest

final class PixelSchedulerUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunchAndHandleAlerts() throws {
        let app = XCUIApplication()
        app.launchArguments.append("-SkipCalendarAccess")
        app.launch()
        
        // Basic check to see if app is running
        // For menu bar apps, .runningBackground is also an acceptable state
        XCTAssertTrue(app.state == .runningForeground || app.state == .runningBackground, "App should be running (either in foreground or background)")
    }
}
