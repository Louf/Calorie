//
//  FoodLibraryView.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 1/30/24.
//

import SwiftUI
import SwiftData

struct FoodLibraryView: View {
    
    @Environment(\.modelContext) private var context

    @Query(sort: [SortDescriptor(\FoodItem.name, order: .reverse)], animation: .snappy) private var allFoodItems: [FoodItem]
    
    @Query(sort: [SortDescriptor(\FoodEntry.date, order: .reverse)], animation: .snappy) private var allFoodEntries: [FoodEntry]
    
    @State private var filteredFoodItems: [FoodItem] = []
    
    @State private var searchText = ""
    
    private func filterFoodItems() {
        if searchText.isEmpty {
            filteredFoodItems = allFoodItems
        } else {
            filteredFoodItems = allFoodItems.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List {
                    ForEach($filteredFoodItems, id: \.self) { foodItem in
                        FoodCard(foodItem: foodItem)
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: delete)
                }
                .padding(.horizontal)
                .navigationTitle("Food Library")
                .searchable(text: $searchText, placement: .navigationBarDrawer)
                .listStyle(PlainListStyle())
                
                .listRowSpacing(12)
                .overlay {
                    if allFoodItems.isEmpty {
                        ContentUnavailableView("No food items", systemImage: "tray.fill")
                    }
                }
                
                
            }
            
        }
        .foregroundStyle(.black)
//        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear(perform: filterFoodItems)
        //On Changes monitors the searchText for filtering as well as the list of foodItems so that it updates when something is deleted
        .onChange(of: searchText){ filterFoodItems() }
        .onChange(of: allFoodItems){ filterFoodItems() }

    }
    
    private func delete(at indexSet: IndexSet) {
        for index in indexSet {
            // Delete related FoodEntry objects
            for foodEntry in allFoodEntries {
                if foodEntry.foodItem.foodID == allFoodItems[index].foodID {
                    context.delete(foodEntry)
                }
            }
            
            // Now delete the FoodItem
            context.delete(allFoodItems[index])
        }
        
        // Save the context after making changes
        do {
            try context.save()
        } catch {
            // Handle the error, e.g., show an alert to the user
            print("Error saving context after deleting food items: \(error)")
        }
    }
}
