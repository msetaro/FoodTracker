//
//  ContentView-ViewModel.swift
//  FoodTracker
//
//  Created by Matthew Setaro on 12/29/24.
//

import Foundation
import SwiftUICore

extension MainView {
    class ViewModel: ObservableObject {

        @State var savedData: [Restaurant] = []
        @Published var isSettingsOpen = false

        func showSettings() {
            withAnimation {
                isSettingsOpen.toggle()
            }
        }
    }
}
