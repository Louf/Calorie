import SwiftUI
import SwiftData

struct FoodSearchView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedFoodItem: FoodItem

    @Query(sort: [SortDescriptor(\FoodItem.name, order: .reverse)], animation: .snappy) private var allFoodEntries: [FoodItem]
    
    @State private var filteredFoodItems: [FoodItem] = []
    
    private func filterFoodItems() {
        if searchText.isEmpty {
            filteredFoodItems = allFoodEntries
        } else {
            filteredFoodItems = allFoodEntries.filter { $0.name.contains(searchText) }
        }
    }
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List {
                    ForEach($filteredFoodItems) { $foodItem in
                        FoodCardNT(foodItem: $foodItem)
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
        .onAppear{
            filterFoodItems()
        }
        .onChange(of: searchText, perform: { _ in filterFoodItems() })


    }
}
