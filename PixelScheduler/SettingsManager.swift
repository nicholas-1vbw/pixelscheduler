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
    }
    
    @Published var beamPosition: BeamPosition {
        didSet { save() }
    }
    
    @Published var beamThickness: Double {
        didSet { save() }
    }
    
    @Published var beamBaseColorHex: String {
        didSet { save() }
    }
    
    @Published var indicatorColorHex: String {
        didSet { save() }
    }
    
    @Published var selectedCalendarIDs: Set<String> {
        didSet { save() }
    }
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        
        // Load values or use defaults
        self.beamPosition = BeamPosition(rawValue: userDefaults.string(forKey: Keys.beamPosition) ?? "") ?? .top
        
        let thickness = userDefaults.double(forKey: Keys.beamThickness)
        self.beamThickness = thickness == 0 ? 10.0 : thickness
        
        self.beamBaseColorHex = userDefaults.string(forKey: Keys.beamBaseColorHex) ?? "#000000"
        self.indicatorColorHex = userDefaults.string(forKey: Keys.indicatorColorHex) ?? "#FF0000"
        
        let savedIDs = userDefaults.stringArray(forKey: Keys.selectedCalendarIDs) ?? []
        self.selectedCalendarIDs = Set(savedIDs)
    }
    
    func save() {
        userDefaults.set(beamPosition.rawValue, forKey: Keys.beamPosition)
        userDefaults.set(beamThickness, forKey: Keys.beamThickness)
        userDefaults.set(beamBaseColorHex, forKey: Keys.beamBaseColorHex)
        userDefaults.set(indicatorColorHex, forKey: Keys.indicatorColorHex)
        userDefaults.set(Array(selectedCalendarIDs), forKey: Keys.selectedCalendarIDs)
    }
}
