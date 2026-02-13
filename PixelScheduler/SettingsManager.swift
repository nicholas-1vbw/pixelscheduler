//
//  SettingsManager.swift
//  PixelScheduler
//
//  Created by Conductor on 2026/2/12.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class SettingsManager: ObservableObject {
    private let userDefaults: UserDefaults
    
    enum Keys {
        static let beamPosition = "beamPosition"
        static let beamThickness = "beamThickness"
        static let beamBaseColorHex = "beamBaseColorHex"
        static let indicatorColorHex = "indicatorColorHex"
        static let selectedCalendarIDs = "selectedCalendarIDs"
        static let selectedDisplayName = "selectedDisplayName"
        static let launchAtLogin = "launchAtLogin"
    }
    
    @Published var beamPosition: BeamPosition
    @Published var beamThickness: Double
    @Published var beamBaseColorHex: String
    @Published var indicatorColorHex: String
    @Published var selectedCalendarIDs: Set<String>
    @Published var selectedDisplayName: String
    @Published var launchAtLogin: Bool
    
    private struct Snapshot {
        let beamPosition: BeamPosition
        let beamThickness: Double
        let beamBaseColorHex: String
        let indicatorColorHex: String
        let selectedCalendarIDs: Set<String>
        let selectedDisplayName: String
        let launchAtLogin: Bool
    }
    
    private var snapshot: Snapshot?
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        
        // Register defaults
        userDefaults.register(defaults: [
            Keys.launchAtLogin: true
        ])
        
        // Load values or use defaults
        self.beamPosition = BeamPosition(rawValue: userDefaults.string(forKey: Keys.beamPosition) ?? "") ?? .top
        
        let thickness = userDefaults.double(forKey: Keys.beamThickness)
        self.beamThickness = thickness == 0 ? 10.0 : thickness
        
        self.beamBaseColorHex = userDefaults.string(forKey: Keys.beamBaseColorHex) ?? "#000000"
        self.indicatorColorHex = userDefaults.string(forKey: Keys.indicatorColorHex) ?? "#FF0000"
        
        let savedIDs = userDefaults.stringArray(forKey: Keys.selectedCalendarIDs) ?? []
        self.selectedCalendarIDs = Set(savedIDs)
        
        self.selectedDisplayName = userDefaults.string(forKey: Keys.selectedDisplayName) ?? ""
        self.launchAtLogin = userDefaults.bool(forKey: Keys.launchAtLogin)
    }
    
    func beginSession() {
        snapshot = Snapshot(
            beamPosition: beamPosition,
            beamThickness: beamThickness,
            beamBaseColorHex: beamBaseColorHex,
            indicatorColorHex: indicatorColorHex,
            selectedCalendarIDs: selectedCalendarIDs,
            selectedDisplayName: selectedDisplayName,
            launchAtLogin: launchAtLogin
        )
    }
    
    func revertSession() {
        guard let snapshot = snapshot else { return }
        beamPosition = snapshot.beamPosition
        beamThickness = snapshot.beamThickness
        beamBaseColorHex = snapshot.beamBaseColorHex
        indicatorColorHex = snapshot.indicatorColorHex
        selectedCalendarIDs = snapshot.selectedCalendarIDs
        selectedDisplayName = snapshot.selectedDisplayName
        launchAtLogin = snapshot.launchAtLogin
        self.snapshot = nil
    }
    
    func save() {
        userDefaults.set(beamPosition.rawValue, forKey: Keys.beamPosition)
        userDefaults.set(beamThickness, forKey: Keys.beamThickness)
        userDefaults.set(beamBaseColorHex, forKey: Keys.beamBaseColorHex)
        userDefaults.set(indicatorColorHex, forKey: Keys.indicatorColorHex)
        userDefaults.set(Array(selectedCalendarIDs), forKey: Keys.selectedCalendarIDs)
        userDefaults.set(selectedDisplayName, forKey: Keys.selectedDisplayName)
        userDefaults.set(launchAtLogin, forKey: Keys.launchAtLogin)
        snapshot = nil
    }
    
    func resolveSelectedScreen() -> NSScreen? {
        if selectedDisplayName.isEmpty {
            return NSScreen.main
        }
        
        return NSScreen.screens.first { $0.localizedName == selectedDisplayName } ?? NSScreen.main
    }
}
