//
//  Intolerance.swift
//  FoodTracker
//
//  Created by Matthew Setaro on 12/29/24.
//

import Foundation
import SwiftData

@Model
final class Intolerance: Identifiable, Equatable, Hashable {
    var id: UUID = UUID()
    
    var foodName: String
    var restaurantId: UUID
    
    var symptoms: [Symptom] = []
    var severity: Int = -1 // 1-10
    
    init(foodName: String, restaurantId: UUID, symptoms: [Symptom], severity: Int) {
        self.foodName = foodName
        self.restaurantId = restaurantId
        self.symptoms = symptoms
        self.severity = severity
    }
    
    static var blank: Intolerance {
        Intolerance(foodName: "", restaurantId: UUID(), symptoms: [], severity: -1)
    }
}
