import SwiftUI

struct NewFoodEntryView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @EnvironmentObject var bannerManager: BannerManager
    
    @State private var servings = "1"
    
    @State private var selectedFoodItem = FoodItem(name: "", calories: 0, unit: .cups, unitAmount: 0, protein: 0, fat: 0, carbs: 0, notes: "")
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    FoodSearchView(selectedFoodItem: $selectedFoodItem)
                } label: {
                    Image(systemName: "plus.app.fill")
                        .padding(.horizontal)
                    Spacer()
                    Text("\(selectedFoodItem.name != "" ? "Change" : "Add") Food Item")
                        .padding(.horizontal)
                        
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .font(.headline.bold())
                .foregroundStyle(.white)
                .background(AnyShapeStyle(.black.gradient), in: .capsule)
                
                if selectedFoodItem.name != "" {
                    FoodCard(foodItem: $selectedFoodItem)
                        .padding(.top)
                    
                    NutritionInput(value: $servings, title: "Servings")
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(selectedFoodItem.protein * (Int(servings) ?? 1))g")
                                .font(.system(size: 26, weight: .bold))
                            Text("Protein")
                        }
                        Spacer()
                        VStack(alignment: .center) {
                            Text("\(selectedFoodItem.fat * (Int(servings) ?? 1))g")
                                .font(.system(size: 26, weight: .bold))
                            Text("Fat")
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("\(selectedFoodItem.carbs * (Int(servings) ?? 1))g")
                                .font(.system(size: 26, weight: .bold))
                            Text("Carbs")
                        }
                    }
                    .font(.subheadline)
                    
                    VStack(alignment: .trailing) {
                        Text("\(selectedFoodItem.calories * (Int(servings) ?? 1))")
                            .font(.system(size: 32, weight: .bold))
                        Text("Cal")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.vertical)
                }
                

                
                //Spacer to push everything up
                Spacer()
            }
            .padding()
            .navigationTitle("Add Food Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //Cancel and add button
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .tint(.red)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        addFoodEntry()
                        print("Added")
                    }
                        .disabled(isAddButtonDisabled)
                }
            }
        }
        
    }
    
    func addFoodEntry(){
        let foodEntry = FoodEntry(foodID: selectedFoodItem.foodID, foodItem: selectedFoodItem, quantity: Int(servings)!, date: Date())
        context.insert(foodEntry)
        bannerManager.displayBanner(image: "fork.knife", message: "Added \(selectedFoodItem.name) to food entries for today")
        dismiss()
    }
    
    var isAddButtonDisabled: Bool {
        if servings != "" && selectedFoodItem.name != "" {
            return false
        } else {
            return true
        }
    }
    
}
