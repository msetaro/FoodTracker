//
//  Restaurant.swift
//  FoodTracker
//
//  Created by Matthew Setaro on 12/29/24.
//

import Foundation
import SwiftData

@Model
final class Restaurant: Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String = ""
    var intolerances: [Intolerance] = []
    
    init(name: String) {
        self.name = name
    }
}
