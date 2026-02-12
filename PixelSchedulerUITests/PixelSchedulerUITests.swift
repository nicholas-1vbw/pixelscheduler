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
        
        // Handle Calendar permission alert automatically
        addUIInterruptionMonitor(withDescription: "Calendar Permission") { (alert) -> Bool in
            if alert.buttons["Allow"].exists {
                alert.buttons["Allow"].tap()
                return true
            }
            if alert.buttons["OK"].exists {
                alert.buttons["OK"].tap()
                return true
            }
            return false
        }
        
        app.launch()
        
        // For status bar apps, we often need to tap the screen or perform an action 
        // to trigger the interruption monitor handler.
        app.tap() 
        
        // Basic check to see if app is running
        XCTAssertEqual(app.state, .runningForeground)
    }
}
