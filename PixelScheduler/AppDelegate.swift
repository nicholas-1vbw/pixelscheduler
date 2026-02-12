//
//  AppDelegate.swift
//  PixelScheduler
//
//  Created by Conductor on 2026/2/12.
//

import AppKit
import SwiftUI
import Combine

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarController: StatusBarController?
    var beamWindow: BeamWindow?
    let calendarManager = CalendarManager()
    private var cancellables = Set<AnyCancellable>()

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Skip initialization logic if we are running in a testing environment
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return
        }

        statusBarController = StatusBarController(calendarManager: calendarManager)
        beamWindow = BeamWindow()
        
        setupSubscriptions()
        
        Task {
            do {
                let granted = try await calendarManager.requestAccess()
                print("Calendar access granted: \(granted)")
                if granted {
                    calendarManager.fetchEvents()
                }
            } catch {
                print("Error requesting calendar access: \(error)")
            }
        }
    }
    
    private func setupSubscriptions() {
        calendarManager.$events
            .receive(on: RunLoop.main)
            .sink { [weak self] events in
                self?.beamWindow?.update(events: events, position: .top)
            }
            .store(in: &cancellables)
    }
}
