//
//  Settings-ViewModel.swift
//  FoodTracker
//
//  Created by Matthew Setaro on 12/29/24.
//

import Foundation
import SwiftUICore

extension SettingsView {
    class ViewModel: ObservableObject {

        var isSettingsShowing: Binding<Bool>

        init(binding: Binding<Bool>) {
            self.isSettingsShowing = binding
        }

        func close() {
            withAnimation {
                isSettingsShowing.wrappedValue = false
            }
        }
    }
}
