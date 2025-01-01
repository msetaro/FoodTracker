//
//  DetailedView-ViewModel.swift
//  FoodTracker
//
//  Created by Matthew Setaro on 12/29/24.
//

import Foundation
import SwiftUICore

extension DetailedView {
    class ViewModel: ObservableObject {
        @Published var intolerance: Intolerance
        
        init(intolerance: Intolerance) {
            self.intolerance = intolerance
        }
        
        func save(intolerance: Intolerance)
        {
            // TODO: Save intolerance to swift data
            
        }
    }
}
