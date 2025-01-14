//
//  FoodTrackerApp.swift
//  FoodTracker
//
//  Created by Matthew Setaro on 12/29/24.
//

import SwiftUI
import SwiftData

@main
struct FoodTrackerApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Restaurant.self,
            Intolerance.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(sharedModelContainer)
    }
}
