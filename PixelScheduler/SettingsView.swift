//
//  SettingsView.swift
//  PixelScheduler
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel: SettingsViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            Form {
                Section(header: Text("Beam Appearance")) {
                    Picker("Position", selection: $viewModel.beamPosition) {
                        Text("Top").tag(BeamPosition.top)
                        Text("Bottom").tag(BeamPosition.bottom)
                        Text("Left").tag(BeamPosition.left)
                        Text("Right").tag(BeamPosition.right)
                    }
                    .pickerStyle(.segmented)
                    
                    VStack(alignment: .leading) {
                        Text("Thickness: \(Int(viewModel.beamThickness)) px")
                        Slider(value: $viewModel.beamThickness, in: 1...50, step: 1)
                    }
                }
                
                Section(header: Text("Base Color")) {
                    ColorControl(hex: $viewModel.beamBaseColorHex)
                }
                
                Section(header: Text("Indicator Color")) {
                    ColorControl(hex: $viewModel.indicatorColorHex)
                }
            }
            .formStyle(.grouped)
            
            Divider()
            
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                .keyboardShortcut(.escape, modifiers: [])
                
                Spacer()
                
                Button("Save") {
                    viewModel.save()
                    dismiss()
                }
                .keyboardShortcut(.defaultAction)
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .frame(width: 400, height: 450)
    }
}

struct ColorControl: View {
    @Binding var hex: String
    
    let presets = ["#000000", "#FFFFFF", "#FF0000", "#00FF00", "#0000FF", "#FFFF00", "#FF00FF", "#00FFFF"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                TextField("Hex", text: $hex)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 80)
                
                ColorPicker("", selection: Binding(
                    get: { Color(hex: hex) },
                    set: { hex = $0.toHex() ?? hex }
                ))
                .labelsHidden()
                
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(presets, id: \.self) { preset in
                        Circle()
                            .fill(Color(hex: preset))
                            .frame(width: 20, height: 20)
                            .overlay(
                                Circle()
                                    .stroke(Color.primary, lineWidth: hex.uppercased() == preset.uppercased() ? 2 : 0)
                            )
                            .onTapGesture {
                                hex = preset
                            }
                    }
                }
                .padding(.vertical, 2)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel(settingsManager: SettingsManager(userDefaults: .standard)))
}
