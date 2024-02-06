//
//  FoodSearchView.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 2/5/24.
//

import SwiftUI
import SwiftData

struct FoodSearchView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedFoodItem: FoodItem

    @Query(sort: [SortDescriptor(\FoodItem.name, order: .reverse)], animation: .snappy) private var allFoodEntries: [FoodItem]
    
    var filteredFoodItems: [FoodItem] {
        guard searchText.isEmpty == false else { return allFoodEntries }

        return allFoodEntries.filter { $0.name.contains(searchText)}
    }
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List {
                    ForEach(filteredFoodItems) { foodItem in
                        FoodCard(foodItem: foodItem)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    context.delete(foodItem)
                                    do {
                                        try context.save()
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                selectedFoodItem = foodItem
                                dismiss()
                            }
                    }
                }
                .padding(.horizontal)
                .navigationTitle("Food Library")
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .listStyle(PlainListStyle())
                
                .listRowSpacing(12)
                .overlay {
                    if allFoodEntries.isEmpty {
                        ContentUnavailableView("No food items", systemImage: "tray.fill")
                    }
                }
                
                
            }
            
        }
        .foregroundStyle(.black)
//        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)

    }
}
