//
//  SettingsView.swift
//  FoodTracker
//
//  Created by Matthew Setaro on 12/29/24.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel: ViewModel
    
    init(isSettingsOpen: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: ViewModel(binding: isSettingsOpen))
    }
    
    var body: some View {
        NavigationStack {
            VStack() {
                Text("This is a settings page")
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            .padding()
            .ignoresSafeArea(edges: .bottom)
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
    }
}

#Preview {
    SettingsView(isSettingsOpen: .constant(true))
}
