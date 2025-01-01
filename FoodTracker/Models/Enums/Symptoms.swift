//
//  Symptoms.swift
//  FoodTracker
//
//  Created by Matthew Setaro on 12/29/24.
//

import Foundation

enum Symptom: String, Codable, CaseIterable {
    case nausea = "Nausea 🤢"
    case diarrhea = "Diarrhea 💩"
    case vomiting = "Vomiting 🤮"
    case cramps = "Cramps 🥴"
    case headache = "Headache 🤕"
    case fatigue = "Fatigue 😴"
    case bloating = "Bloating 🤰"
    case gas = "Gas 💨"
    case constipation = "Constipation 🚫"
    case skin = "Skin 🧴"
    case other = "Other 🆘"
}

