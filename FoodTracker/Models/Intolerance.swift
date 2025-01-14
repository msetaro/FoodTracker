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
    var foodName: String = ""
    var symptoms: Set<Symptom> = []
    var severity: Int = -1
    weak var restaurant: Restaurant?
    
    init(foodName: String, symptoms: Set<Symptom>, severity: Int) {
        self.foodName = foodName
        self.symptoms = symptoms
        self.severity = severity
    }
    
    static var blank: Intolerance {
        Intolerance(foodName: "", symptoms: [], severity: -1)
    }
}
