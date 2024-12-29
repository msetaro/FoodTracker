//
//  Resturant.swift
//  FoodTracker
//
//  Created by Matthew Setaro on 12/29/24.
//

import Foundation

struct Restaurant: Identifiable, Hashable {
    
    var id: UUID
    var name: String
    
    var foodItems: [Intolerance] = []
    
    init(name: String, intolerances: [Intolerance] = []) {
        self.id = UUID()
        self.name = name
        
        self.foodItems = intolerances
    }
    
    mutating func addIntolerance(_ intolerance: Intolerance) {
        foodItems.append(intolerance)
    }

    static var sample: [Restaurant] {
        [
            Restaurant(name: "Taco Bell", intolerances: [Intolerance(foodName: "Cheesy Gordita Crunch")]),
            Restaurant(name: "McDonalds", intolerances: [Intolerance(foodName: "Quarter pounder with cheese")]),
            Restaurant(name: "Chipotle", intolerances: [Intolerance(foodName: "Burrito")]),
            Restaurant(name: "Moes", intolerances: [Intolerance(foodName: "Homewrecker")]),
            Restaurant(name: "Shah's Halal", intolerances: [Intolerance(foodName: "Chicken over rice")]),
            Restaurant(name: "Rocky Point Pizza", intolerances: [Intolerance(foodName: "Buffalo chicken pizza")]),
            Restaurant(name: "Ruggero's", intolerances: [Intolerance(foodName: "Rigatoni Bolognese")]),
            Restaurant(name: "Miguel's", intolerances: [Intolerance(foodName: "Tacos")]),
            Restaurant(name: "Primo", intolerances: [Intolerance(foodName: "Prime Rib")]),
            Restaurant(name: "Matteo's", intolerances: [Intolerance(foodName: "Penne alla vodka")])
        ]
    }
}
