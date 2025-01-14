//
//  SettingsView.swift
//  FoodTracker
//
//  Created by Matthew Setaro on 12/29/24.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel: ViewModel
    
    @AppStorage("appAppearance") private var appAppearance: SystemAppearance = .light
    @Environment(\.colorScheme) var systemColorScheme

    @State private var selectedAppearance: SystemAppearance = .light
    
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    private let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String

    
    init(isSettingsOpen: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: ViewModel(binding: isSettingsOpen))
    }
    
    var body: some View {
        NavigationStack {
            VStack() {
                List {
                    Picker("Theme", selection: $selectedAppearance) {
                        Text("Light").tag(SystemAppearance.light)
                        Text("Dark").tag(SystemAppearance.dark)
                    }.onChange(of: selectedAppearance) { oldValue, newValue in
                        handleAppearanceChange(newValue)
                    }
                }
                Spacer()
                Text("Version \(appVersion ?? "") build \(appBuild ?? "")")
                    .foregroundStyle(.tertiary)
                    .padding(.bottom, 50)
            }
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            .background(Color.secondary.opacity(0.1))
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
                selectedAppearance = appAppearance
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Settings")
                        .font(.headline)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: viewModel.close) {
                        Text("Done")
                            .foregroundStyle(.blue)
                            .font(.headline)
                    }
                }
            }
        }
        .preferredColorScheme(selectedAppearance == .dark ? .dark : .light)

    }
    
    func handleAppearanceChange(_ value: SystemAppearance) {
        // update backing
        UserDefaults.standard.set(value.rawValue, forKey: "appAppearance")
    }
}

#Preview {
    SettingsView(isSettingsOpen: .constant(true))
}
