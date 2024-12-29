//
//  DetailedView.swift
//  FoodTracker
//
//  Created by Matthew Setaro on 12/29/24.
//

import SwiftUI

struct DetailedView: View {
    @StateObject private var viewModel: ViewModel
    
    init(intolerance: Intolerance) {
        _viewModel = StateObject(wrappedValue: ViewModel(intolerance: intolerance))
    }
    
    var body: some View {
        VStack {
            Text("Awh, did \(viewModel.intolerance.foodName) hurt your tummy?")
        }.navigationTitle("Details")
    }
}

#Preview {
    DetailedView(intolerance: Intolerance(foodName: "chicken nuggets"))
}
