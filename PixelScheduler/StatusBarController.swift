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
        if settingsWindow == nil {
            let viewModel = SettingsViewModel(settingsManager: settingsManager, calendarManager: calendarManager)
            let settingsView = SettingsView(viewModel: viewModel)
            let hostingView = NSHostingView(rootView: settingsView)
            
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 400, height: 500),
                styleMask: [.titled, .closable],
                backing: .buffered,
                defer: false
            )
            window.center()
            window.title = "PixelScheduler Preferences"
            window.contentView = hostingView
            window.isReleasedWhenClosed = false
            self.settingsWindow = window
        }
        
        NSApp.activate(ignoringOtherApps: true)
        settingsWindow?.makeKeyAndOrderFront(nil)
    }
    
    @objc func refresh() {
        calendarManager.fetchEvents()
    }
    
    @objc func exitApp() {
        NSApplication.shared.terminate(nil)
    }
}
