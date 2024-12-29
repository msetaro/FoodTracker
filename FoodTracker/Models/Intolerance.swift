//
//  Intolerance.swift
//  FoodTracker
//
//  Created by Matthew Setaro on 12/29/24.
//

import Foundation

struct Intolerance: Identifiable, Equatable, Hashable {
    var id: UUID = UUID()
    var foodName: String
    var symptoms: [Symptom] = []
}
