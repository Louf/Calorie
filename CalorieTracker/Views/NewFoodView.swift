//
//  NewFoodView.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 2/1/24.
//

import SwiftUI
import SwiftData

struct NewFoodView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var bannerManager: BannerManager
    
    @State private var calories = ""
    @State private var protein = ""
    @State private var fat = ""
    @State private var carbs = ""
    @State private var name = ""
    @State private var notes = ""
    
    @State private var unit: FoodUnit = .grams
    @State private var unitAmount = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("New Food Item")
                .font(.system(size: 42, weight: .bold))
            //Extracted out the views because they're quite big and would make this view look ugly
            NutritionTextInput(value: $name, textSize: 36)
            
            NutritionInput(value: $calories,    title: "Calories")
            Divider()
            NutritionInput(value: $protein,     title: "Protein")
            Divider()
            NutritionInput(value: $fat,         title: "Fat")
            Divider()
            NutritionInput(value: $carbs,       title: "Carbs")
            
            NutritionMultiTextInput(value: $notes, textSize: 24)
            
            UnitPicker(selectedUnit: $unit, unitAmount: $unitAmount)
            
            HStack{
                Spacer()
                Button {
                    addFood()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .foregroundStyle(isAddButtonDisabled ? .ultraThinMaterial : .ultraThickMaterial)
                            .environment(\.colorScheme, .dark)
                            .frame(height: UIScreen.main.bounds.height / 14)
                            .frame(maxWidth: UIScreen.main.bounds.width / 1.5)
                        
                        Text("Confirm")
                            .foregroundStyle(.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                }
                .disabled(isAddButtonDisabled)
                .padding(.bottom, 44)
                Spacer()
            }
        }
        .foregroundStyle(.black)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
    
    //Disabling add button until all data has been entered
    var isAddButtonDisabled: Bool {
        return unitAmount.isEmpty || name.isEmpty || calories.isEmpty || protein.isEmpty || carbs.isEmpty || fat.isEmpty
    }
    
    //All of the ints are forced unwrap because we cannot get to this function unless all of the values are filled out.
    func addFood(){
        let food = FoodItem(name: name, calories: Int(calories)!, unit: unit, unitAmount: Int(unitAmount)!, protein: Int(protein)!, fat: Int(fat)!, carbs: Int(carbs)!, notes: notes)
        context.insert(food)
        bannerManager.displayBanner(image: "carrot.fill", message: "Added \(name) to foods")
        resetValues()
    }
    
    //Reset all the values in the view
    func resetValues(){
        (calories, fat, carbs, protein, notes, name, unitAmount, unit) = ("", "", "", "", "", "", "", .grams)
    }
}

#Preview {
    NewFoodView()
}
