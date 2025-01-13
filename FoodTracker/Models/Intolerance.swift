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
    
    weak var restaurant: Restaurant?
    var foodName: String
    var symptoms: [Symptom] = []
    var severity: Int = -1 // 1-10
    
    init(foodName: String, symptoms: [Symptom], severity: Int) {
        self.foodName = foodName
        self.symptoms = symptoms
        self.severity = severity
    }
    
    static var blank: Intolerance {
        Intolerance(foodName: "", symptoms: [], severity: -1)
    }
}
