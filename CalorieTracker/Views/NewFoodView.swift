//
//  NewFoodView.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 2/1/24.
//

import SwiftUI
import SwiftData

struct NewFoodView: View {
    @State private var calories = ""
    @State private var protein = ""
    @State private var fat = ""
    @State private var carbs = ""
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("New Food Item")
                .font(.system(size: 48, weight: .bold))
            //Extracted out the views because they're quite big and would make this view look ugly
            NutritionInput(value: $calories,    title: "Calories")
            NutritionInput(value: $protein,     title: "Protein")
            NutritionInput(value: $fat,         title: "Fat")
            NutritionInput(value: $carbs,       title: "Carbs")
            Spacer()
            
            HStack{
                Spacer()
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .foregroundStyle(.ultraThinMaterial)
                            .frame(height: UIScreen.main.bounds.height / 14)
                            .frame(maxWidth: UIScreen.main.bounds.width / 1.5)
                        
                        Text("Confirm")
                            .foregroundStyle(.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                }
                .padding(.bottom, 62)
                Spacer()
            }
        }
        .foregroundStyle(.black)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

#Preview {
    NewFoodView()
}
