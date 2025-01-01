//
//  ContentView.swift
//  FoodTracker
//
//  Created by Matthew Setaro on 12/29/24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                // List of restaurants and intolerances
                if viewModel.savedData.isEmpty {
                    Text("No intolerances recorded yet. Tap the '+' button in the top right corner to add one.")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .padding()
                    Spacer()
                }
                else {
//                    List {
//                        ForEach(viewModel.savedData) { restaurant in
//                            Section(header: Text(restaurant.name)) {
//                                ForEach(restaurant.foodItems, id: \.id) { food in
//                                    NavigationLink(food.foodName, value: food)
//                                }
//                            }.headerProminence(.increased)
//                        }
//                    }
                }
            }
            .navigationTitle("Foods")
            .navigationDestination(for: Intolerance.self) { intolerance in
                DetailedView(selectedIntolerance: intolerance, isUpdate: true)
            }
            .toolbar {
                // Settings
                ToolbarItem(placement: .navigation) {
                    Button(action: viewModel.showSettings) {
                        Label("Settings", systemImage: "gear")}
                    }
                
                // Add item
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: DetailedView(selectedIntolerance: Intolerance.blank, isUpdate: false)) {
                        Label("Add", systemImage: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $viewModel.isSettingsOpen) {
                SettingsView(isSettingsOpen: $viewModel.isSettingsOpen)
            }
        }
    }
}

#Preview {
    MainView()
}
