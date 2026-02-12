//
//  StatusBarController.swift
//  PixelScheduler
//
//  Created by Conductor on 2026/2/12.
//

import AppKit
import SwiftUI

class StatusBarController: NSObject {
    var statusItem: NSStatusItem!
    private let calendarManager: CalendarManager
    private let settingsManager: SettingsManager
    private var settingsWindow: NSWindow?
    
    init(calendarManager: CalendarManager, settingsManager: SettingsManager) {
        self.calendarManager = calendarManager
        self.settingsManager = settingsManager
        super.init()
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        setupMenu()
    }
    
    private func setupMenu() {
        let menu = NSMenu()
        
        let settingsItem = NSMenuItem(title: "Settings...", action: #selector(openSettings), keyEquivalent: ",")
        settingsItem.target = self
        menu.addItem(settingsItem)
        
        let refreshItem = NSMenuItem(title: "Update Now", action: #selector(refresh), keyEquivalent: "r")
        refreshItem.target = self
        menu.addItem(refreshItem)
        
        menu.addItem(NSMenuItem.separator())
        
        let exitItem = NSMenuItem(title: "Exit", action: #selector(exitApp), keyEquivalent: "q")
        exitItem.target = self
        menu.addItem(exitItem)
        
        statusItem.menu = menu
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "calendar", accessibilityDescription: "PixelScheduler")
        }
    }
    
    @objc func openSettings() {
        print("DEBUG: openSettings called")
        
        // Ensure UI operations are on MainActor/MainThread
        Task { @MainActor in
            print("DEBUG: Executing on MainActor")
            if self.settingsWindow == nil {
                print("DEBUG: Creating new settings window")
                let viewModel = SettingsViewModel(settingsManager: self.settingsManager, calendarManager: self.calendarManager)
                let settingsView = SettingsView(viewModel: viewModel)
                let hostingView = NSHostingView(rootView: settingsView)
                
                let window = NSWindow(
                    contentRect: NSRect(x: 0, y: 0, width: 400, height: 500),
                    styleMask: [.titled, .closable, .miniaturizable],
                    backing: .buffered,
                    defer: false
                )
                window.center()
                window.title = "PixelScheduler Preferences"
                window.contentView = hostingView
                window.isReleasedWhenClosed = false
                window.delegate = self
                self.settingsWindow = window
                print("DEBUG: Window created")
            }
            
            print("DEBUG: Ordering front and activating")
            self.settingsWindow?.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            print("DEBUG: openSettings finished")
        }
    }
    
    @objc func refresh() {
        calendarManager.fetchEvents(calendarIDs: settingsManager.selectedCalendarIDs)
    }
    
    @objc func exitApp() {
        NSApplication.shared.terminate(nil)
    }
}

extension StatusBarController: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        // Just let it hide, it's not released when closed
    }
}
