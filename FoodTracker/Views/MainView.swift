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
                List {
                    ForEach(viewModel.dummyData) { restaurant in
                        Section(header: Text(restaurant.name)) {
                            ForEach(restaurant.foodItems, id: \.id) { food in
                                NavigationLink(food.foodName, value: food)
                            }
                        }.headerProminence(.increased)
                    }
                }
            }
            .navigationTitle("Foods")
            .navigationDestination(for: Intolerance.self) { intolerance in
                DetailedView(intolerance: intolerance)
            }
            .toolbar {
                // Settings
                ToolbarItem(placement: .navigation) {
                    Button(action: viewModel.showSettings) {
                        Label("Settings", systemImage: "gear")
                    }
                }
                
                // Add item
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: viewModel.addItem) {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
