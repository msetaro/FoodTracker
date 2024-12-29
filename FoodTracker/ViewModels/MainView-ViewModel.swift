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
        
        @State var dummyData = Restaurant.sample
        @Published var isSettingsOpen = false
        
        func addItem() {
            
        }
        
        func showSettings() {
            withAnimation {
                isSettingsOpen.toggle()
            }
        }
    }
}
