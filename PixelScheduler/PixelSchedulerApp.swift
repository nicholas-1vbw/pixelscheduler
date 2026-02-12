//
//  PixelSchedulerApp.swift
//  PixelScheduler
//
//  Created by Nicholas on 2026/2/10.
//

import SwiftUI

@main
struct PixelSchedulerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            ContentView()
        }
    }
}
