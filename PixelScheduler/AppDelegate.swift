//
//  AppDelegate.swift
//  PixelScheduler
//
//  Created by Conductor on 2026/2/12.
//

import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarController: StatusBarController?
    let calendarManager = CalendarManager()

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusBarController = StatusBarController()
        
        Task {
            do {
                let granted = try await calendarManager.requestAccess()
                print("Calendar access granted: \(granted)")
            } catch {
                print("Error requesting calendar access: \(error)")
            }
        }
    }
}
