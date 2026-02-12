//
//  StatusBarController.swift
//  PixelScheduler
//
//  Created by Conductor on 2026/2/12.
//

import AppKit

class StatusBarController: NSObject {
    var statusItem: NSStatusItem!
    private let calendarManager: CalendarManager
    
    init(calendarManager: CalendarManager) {
        self.calendarManager = calendarManager
        super.init()
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        setupMenu()
    }
    
    private func setupMenu() {
        let menu = NSMenu()
        
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
    
    @objc func refresh() {
        calendarManager.fetchEvents()
    }
    
    @objc func exitApp() {
        NSApplication.shared.terminate(nil)
    }
}
