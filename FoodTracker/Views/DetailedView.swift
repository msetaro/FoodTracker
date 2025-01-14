//
//  DetailedView.swift
//  FoodTracker
//
//  Created by Matthew Setaro on 12/29/24.
//

import SwiftUI
import SwiftData

struct DetailedView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode
    
    @State var selectedIntolerance: Intolerance?
    @State var correspondingRestaurant: Restaurant?
    var isUpdate: Bool
    
    private var showAlert: Bool {
        !restaurantName.isEmpty || !foodItemName.isEmpty || !symptoms.isEmpty || severity > 1
    }
    
    @State var isAlertShowing: Bool = false
    @State var hasInitialized: Bool = false
    
    // User input
    @State var restaurantName: String = ""
    @State var foodItemName: String = ""
    @State var symptoms: Set<Symptom> = []
    @State var severity: Int = 1

    init(selectedIntolerance: Intolerance?, correspondingRestaurant: Restaurant?) {
        self.selectedIntolerance = selectedIntolerance
        self.correspondingRestaurant = correspondingRestaurant
        self.isUpdate = selectedIntolerance != nil && correspondingRestaurant != nil
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
                        NavigationLink(
                            destination: SymptomSelectionView(selectedItems: $symptoms)
                        ) {
                            // Symptoms chips
                            if symptoms.isEmpty {
                                Text("None")
                                    .foregroundColor(.gray)
                            } else {
                                var cols = [
                                    GridItem(.adaptive(minimum: 100), spacing: 0),
                                    GridItem(.adaptive(minimum: 100), spacing: 0)
                                ]
                                LazyVGrid(columns: cols, spacing: 5) {
                                    ForEach(Array(symptoms), id: \.self) { symptom in
                                        Text(symptom.rawValue)
                                            .font(.body)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color.blue.opacity(0.1))
                                            .cornerRadius(20)
                                            .foregroundColor(.blue)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color.blue, lineWidth: 1)
                                            )
                                            .padding(2)
                                    }
                                }.frame(maxWidth: .infinity)
                            }
                        }
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
                    save(foodItemName: foodItemName, restaurantName: restaurantName, severity: severity, symptoms: symptoms)
                    
                    // dismiss page
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
        .onAppear {
            if !hasInitialized {
                // Ensure the values are set once the view appears
                if let intolerance = selectedIntolerance {
                    restaurantName = intolerance.restaurant?.name ?? ""
                    foodItemName = intolerance.foodName
                    symptoms = intolerance.symptoms
                    severity = intolerance.severity
                } else if let restaurant = correspondingRestaurant {
                    restaurantName = restaurant.name
                }
                
                hasInitialized = true
            }
        }
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
    
    func save(foodItemName: String, restaurantName: String, severity: Int, symptoms: Set<Symptom>) {
        
        let intol: Intolerance = Intolerance(foodName: foodItemName, symptoms: symptoms, severity: severity)
        var rest: Restaurant? = correspondingRestaurant
        
        // a new intolerance
        if(correspondingRestaurant == nil) {
            
            
            // check if restaurant exists
            rest = getRestaurant(name: restaurantName)
            
            // add intolerance to this restaurant
            rest?.intolerances.append(intol)
        }
        // editing an intolerance
        else {
            // if the restaurant name was changed, query the model context for the restaurant by name
            if(restaurantName != correspondingRestaurant!.name) {
                rest = getRestaurant(name: restaurantName)
                
                // add intolerance to this restaurant
                rest?.intolerances.append(intol)
                
                // remove reference to old restaurant
                let idx = correspondingRestaurant!.intolerances.firstIndex(of: selectedIntolerance!)
                correspondingRestaurant!.intolerances.remove(at: idx!)
                
                // if there are no more intolerances for this old restaurant now
                // need to delete it
                if(correspondingRestaurant!.intolerances.isEmpty) {
                    context.delete(correspondingRestaurant!)
                }
            }
            // update in place
            else {
                // might need a binding to change if this doesnt work
                selectedIntolerance?.foodName = foodItemName
                selectedIntolerance?.severity = severity
                selectedIntolerance?.symptoms = symptoms
            }
        }
        
        // save to model context
        context.insert(rest!)
        
        do {
            try context.save()
        }
        catch {
            print("error while saving model context")
        }
    }
    
    private func getRestaurant(name: String) -> Restaurant {
        var rest: Restaurant
        let fetchDesc = FetchDescriptor<Restaurant>(predicate: #Predicate { restaurant in
            restaurant.name == name
        })
        
        do {
            // Attempt to fetch the restaurant
            let exists = try context.fetch(fetchDesc)
            if let existingRestaurant = exists.first {
                rest = existingRestaurant
            } else {
                // If no restaurant matches, create a new one
                rest = Restaurant(name: name)
                context.insert(rest) // Add the new restaurant to the context
            }
        } catch {
            // Handle fetch errors (e.g., malformed predicate)
            print("Fetch error: \(error)")
            rest = Restaurant(name: name)
        }

        
        return rest
    }
}

#Preview {
    DetailedView(selectedIntolerance: Intolerance(foodName: "chicken nuggets", symptoms: [.bloating, .constipation, .cramps], severity: 5), correspondingRestaurant: nil)
}
