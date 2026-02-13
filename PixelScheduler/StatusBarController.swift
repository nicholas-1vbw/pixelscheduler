//
//  StatusBarController.swift
//  PixelScheduler
//
//  Created by Conductor on 2026/2/12.
//

import AppKit
import SwiftUI

@MainActor
class StatusBarController: NSObject {
    var statusItem: NSStatusItem!
    private let calendarManager: CalendarManager
    private let settingsManager: SettingsManager
    private var settingsWindow: NSWindow?
    private var currentViewModel: SettingsViewModel?
    
    init(calendarManager: CalendarManager, settingsManager: SettingsManager) {
        self.calendarManager = calendarManager
        self.settingsManager = settingsManager
        super.init()
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        setupMenu()
    }
    
    private func setupMenu() {
        let menu = NSMenu()
        menu.delegate = self
        
        let settingsItem = NSMenuItem(title: "Settings...", action: #selector(openSettings), keyEquivalent: ",")
        settingsItem.target = self
        menu.addItem(settingsItem)
        
        let refreshItem = NSMenuItem(title: "Update Now", action: #selector(refresh), keyEquivalent: "r")
        refreshItem.target = self
        menu.addItem(refreshItem)
        
        let launchAtLoginItem = NSMenuItem(title: "Launch at Login", action: #selector(toggleLaunchAtLogin), keyEquivalent: "")
        launchAtLoginItem.target = self
        menu.addItem(launchAtLoginItem)
        
        menu.addItem(NSMenuItem.separator())
        
        let displayItem = NSMenuItem(title: "Display", action: nil, keyEquivalent: "")
        displayItem.submenu = NSMenu()
        menu.addItem(displayItem)
        
        menu.addItem(NSMenuItem.separator())
        
        let exitItem = NSMenuItem(title: "Exit", action: #selector(exitApp), keyEquivalent: "q")
        exitItem.target = self
        menu.addItem(exitItem)
        
        statusItem.menu = menu
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "calendar", accessibilityDescription: "PixelScheduler")
        }
        
        updateDisplayMenu()
    }
    
    private func updateDisplayMenu() {
        guard let displayItem = statusItem.menu?.items.first(where: { $0.title == "Display" }),
              let submenu = displayItem.submenu else { return }
        
        submenu.removeAllItems()
        
        let screens = NSScreen.screens
        for screen in screens {
            let item = NSMenuItem(title: screen.localizedName, action: #selector(switchDisplay(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = screen
            item.state = (screen.localizedName == settingsManager.selectedDisplayName) ? .on : .off
            submenu.addItem(item)
        }
        
        // If nothing is selected, check the main screen
        if !submenu.items.contains(where: { $0.state == .on }), let mainScreen = NSScreen.main {
            if let item = submenu.items.first(where: { $0.title == mainScreen.localizedName }) {
                item.state = .on
            }
        }
    }
    
    @objc func switchDisplay(_ sender: NSMenuItem) {
        if let screen = sender.representedObject as? NSScreen {
            settingsManager.selectedDisplayName = screen.localizedName
            settingsManager.save()
            updateDisplayMenu()
            // The BeamWindow should observe settingsManager and move itself.
            // In PixelSchedulerApp.swift, it might need to react to this change.
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
                self.currentViewModel = viewModel
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
    
    @objc func toggleLaunchAtLogin() {
        settingsManager.launchAtLogin.toggle()
        settingsManager.save()
    }
}

extension StatusBarController: NSMenuDelegate {
    func menuWillOpen(_ menu: NSMenu) {
        if let launchItem = menu.items.first(where: { $0.title == "Launch at Login" }) {
            launchItem.state = settingsManager.launchAtLogin ? .on : .off
        }
        updateDisplayMenu()
    }
}

extension StatusBarController: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        if let viewModel = currentViewModel, !viewModel.isSaved {
            viewModel.cancel()
        }
        currentViewModel = nil
        settingsWindow = nil // Release the window so it's recreated next time with fresh state
    }
}
