//
//  SettingsViewModel.swift
//  PixelScheduler
//

import Foundation
import SwiftUI
import Combine

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var beamPosition: BeamPosition
    @Published var beamThickness: Double
    @Published var beamBaseColorHex: String
    @Published var indicatorColorHex: String
    @Published var selectedCalendarIDs: Set<String>
    
    private let settingsManager: SettingsManager
    
    init(settingsManager: SettingsManager) {
        self.settingsManager = settingsManager
        self.beamPosition = settingsManager.beamPosition
        self.beamThickness = settingsManager.beamThickness
        self.beamBaseColorHex = settingsManager.beamBaseColorHex
        self.indicatorColorHex = settingsManager.indicatorColorHex
        self.selectedCalendarIDs = settingsManager.selectedCalendarIDs
    }
    
    func save() {
        settingsManager.beamPosition = beamPosition
        settingsManager.beamThickness = beamThickness
        settingsManager.beamBaseColorHex = beamBaseColorHex
        settingsManager.indicatorColorHex = indicatorColorHex
        settingsManager.selectedCalendarIDs = selectedCalendarIDs
    }
}
