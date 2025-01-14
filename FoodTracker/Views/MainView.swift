//
//  ContentView.swift
//  FoodTracker
//
//  Created by Matthew Setaro on 12/29/24.
//

import SwiftUI
import SwiftData

struct MainView: View {

    @StateObject var viewModel = ViewModel()
    @Query private var savedData: [Restaurant]
    @Environment(\.modelContext) private var modelContext
    @AppStorage("appAppearance") private var appAppearance: SystemAppearance = .light
    @Environment(\.colorScheme) var systemColorScheme

    var body: some View {
        NavigationStack {
            VStack {
                // List of restaurants and intolerances
                if savedData.isEmpty {
                    Text("No intolerances recorded yet. Tap the '+' button in the top right corner to add one.")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .padding()
                    Spacer()
                } else {
                    List {
                        ForEach(savedData) { restaurant in
                            Section(header: Text(restaurant.name)) {
                                ForEach(restaurant.intolerances, id: \.id) { intolerance in
                                    NavigationLink(value: intolerance) {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text(intolerance.foodName)
                                                    .fontWeight(.medium)
                                                Text("\(intolerance.severity)/10")
                                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                            }
                                            .padding(2)
                                            Text(intolerance.symptoms.map(\.rawValue).joined(separator: ", "))
                                                .foregroundStyle(.secondary)
                                        }
                                        .frame(maxHeight: 50)
                                        .clipped()
                                    }
                                }
                                .onDelete(perform: deleteIntolerance)
                            }.headerProminence(.increased)
                        }
                    }
                }
            }
            .navigationTitle("Foods")
            .preferredColorScheme(appAppearance == .dark ? .dark : .light)
            .navigationDestination(for: Intolerance.self) { intolerance in
                DetailedView(selectedIntolerance: intolerance, correspondingRestaurant: intolerance.restaurant)
            }
            .toolbar {
                // Settings
                ToolbarItem(placement: .navigation) {
                    Button(action: viewModel.showSettings) {
                        Label("Settings", systemImage: "gear")}
                    }

                // Add item
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: DetailedView(selectedIntolerance: nil, correspondingRestaurant: nil)) {
                        Label("Add", systemImage: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $viewModel.isSettingsOpen) {
                SettingsView(isSettingsOpen: $viewModel.isSettingsOpen)
            }
        }
    }

    private func deleteIntolerance(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(savedData[index])
            }
        }

        do {
            try modelContext.save()
        } catch {
            print("error saving changes when deleting")
        }

    }
 }

#Preview {
    MainView()
}
