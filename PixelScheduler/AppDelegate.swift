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
    let settingsManager = SettingsManager()
    private var cancellables = Set<AnyCancellable>()

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Skip initialization logic if we are running in a unit testing environment
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return
        }

        statusBarController = StatusBarController(calendarManager: calendarManager, settingsManager: settingsManager)
        beamWindow = BeamWindow(settings: settingsManager)
        
        setupSubscriptions()
        
        // Skip permission request if requested by launch argument (useful for UI tests)
        if CommandLine.arguments.contains("-SkipCalendarAccess") {
            print("Skipping calendar access request as per launch argument.")
            return
        }
        
        Task {
            do {
                let granted = try await calendarManager.requestAccess()
                print("Calendar access granted: \(granted)")
                if granted {
                    calendarManager.fetchEvents(calendarIDs: settingsManager.selectedCalendarIDs)
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
                guard let self = self else { return }
                self.beamWindow?.update(events: events, settings: self.settingsManager)
            }
            .store(in: &cancellables)
            
        settingsManager.objectWillChange
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.beamWindow?.update(events: self.calendarManager.events, settings: self.settingsManager)
                    self.calendarManager.fetchEvents(calendarIDs: self.settingsManager.selectedCalendarIDs)
                }
            }
            .store(in: &cancellables)
    }
}
