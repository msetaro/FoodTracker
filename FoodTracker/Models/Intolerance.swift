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
    var severity: Int = -1           // 1-10
}
