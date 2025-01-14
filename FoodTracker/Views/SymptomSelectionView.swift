//
//  SymptomSelectionView.swift
//  FoodTracker
//
//  Created by Matthew Setaro on 1/13/25.
//

import SwiftUI

struct SymptomSelectionView: View {
    @Binding var selectedItems: Set<Symptom>
    @AppStorage("appAppearance") private var appAppearance: SystemAppearance = .light
    @Environment(\.colorScheme) var systemColorScheme

    var body: some View {
        NavigationView {
            List {
                ForEach(Symptom.allCases, id: \.self) { symptom in
                    HStack {
                        Text(symptom.rawValue)
                        Spacer()
                        if selectedItems.contains(symptom) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle()) // Makes the entire row tappable
                    .padding(8)
                    .onTapGesture {
                        toggleSelection(for: symptom)
                    }
                }
            }
        }
        .navigationTitle("Select Symptoms")
        .preferredColorScheme(appAppearance == .dark ? .dark : .light)
    }

    private func toggleSelection(for symptom: Symptom) {
        if selectedItems.contains(symptom) {
            selectedItems.remove(symptom) // Deselect
        } else {
            selectedItems.insert(symptom) // Select
        }
    }
}

#Preview {
//    SymptomSelectionView(selectedItems: Binding<Set<Symptom>>(projectedValue: []))
}
