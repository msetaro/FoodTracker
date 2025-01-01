//
//  DetailedView.swift
//  FoodTracker
//
//  Created by Matthew Setaro on 12/29/24.
//

import SwiftUI

struct DetailedView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @StateObject private var viewModel: ViewModel
    
    var selectedIntolerance: Intolerance
    var isUpdate: Bool
    
    // User input
    @State var restaurantName: String = ""
    
    @State var foodItemName: String = ""
    
    @State var symptoms: [Symptom] = [.bloating]
    
    @State var severity: Int = 1
    
    @State var isAlertShowing: Bool = false
    
    private var showAlert: Bool {
        !restaurantName.isEmpty || !foodItemName.isEmpty || !symptoms.isEmpty || severity > 1
    }
    
    
    init(selectedIntolerance: Intolerance, isUpdate: Bool) {
        _viewModel = StateObject(wrappedValue: ViewModel(intolerance: selectedIntolerance))
        self.selectedIntolerance = selectedIntolerance
        self.isUpdate = isUpdate
    }
    
    var body: some View {
        VStack {
            VStack {
                List {
                    // Resturant
                    Section {
                        TextField("Restaurant name", text: $restaurantName)
                    } header: {
                        Text("Resturant")
                    } footer: {
                        Text("The restaurant you ordered from")
                    }
                    
                    // Food item
                    Section {
                        TextField("Food name", text: $foodItemName)
                    } header: {
                        Text("Food")
                    } footer: {
                        Text("The food that you ate")
                    }
                    
                    // Symptoms
                    Section {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(Symptom.allCases, id: \.self) { symptom in
                                    Text(symptom.rawValue)
                                        .padding()
                                }
                            }.padding(10)
                        }
                        .frame(height: 55)
                    } header: {
                        Text("Symptoms")
                    } footer: {
                        Text("Your symptoms after eating the food")
                    }
                    
                    // Severity
                    Section {
                        VStack {
                            Text("\(severity)")
                            
                            HStack {
                                Text("1")
                                    .foregroundStyle(.secondary)
                                
                                Slider(
                                    value: Binding<Double>(
                                        get: { Double(severity) },
                                        set: { severity = Int($0.rounded()) }
                                    ),
                                    in: 1...10,
                                    step: 1)
                                
                                Text("10")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    header: {
                        Text("Severity")
                    } footer: {
                        Text("The severity of your symptoms after eating the food")
                    }
                }
                
                Button(action: {
                    // Save to SwiftData
                    
                    
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .frame(maxWidth: .infinity, maxHeight: 40) // Makes the button span the full width
                }
                .disabled(restaurantName.isEmpty || foodItemName.isEmpty || symptoms.isEmpty)
                .padding()
                .buttonStyle(.borderedProminent)
            }
        }
        .navigationTitle(isUpdate ? "Update Intolerance" : "Add Intolerance")
        .background(Color.secondary.opacity(0.1))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    if showAlert {
                        isAlertShowing = true
                    } else {
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .fontWeight(.medium)
                        Text("Back")
                    }
                }
            }
        }
        .alert("Unsaved Changes", isPresented: $isAlertShowing) {
            Button("Discard Changes", role: .destructive) {
                presentationMode.wrappedValue.dismiss()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("You have unsaved changes. Are you sure you want to go back?")
        }
    }
}

#Preview {
    DetailedView(selectedIntolerance: Intolerance(foodName: "chicken nuggets", restaurantId: UUID(), symptoms: [], severity: 5), isUpdate: false)
}
