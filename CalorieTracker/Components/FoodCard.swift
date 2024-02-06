//
//  FoodCard.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 2/4/24.
//

import SwiftUI

struct FoodCard: View {
    @Bindable var foodItem: FoodItem
    
    var body: some View {
        VStack {
            HStack {
                Text(foodItem.name)
                Spacer()
                Text("\(foodItem.unitAmount)\(foodItem.unitString)")
                Spacer()
                Text("\(foodItem.calories) cal")
            }
            .font(.headline.bold())
            .padding(.bottom)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("\(foodItem.protein)g")
                    Text("Protein")
                }
                Spacer()
                VStack(alignment: .center) {
                    Text("\(foodItem.fat)g")
                    Text("Fat")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(foodItem.carbs)g")
                    Text("Carbs")
                }
            }
            .font(.subheadline)
        }
        .foregroundStyle(.white)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.ultraThinMaterial)
                .environment(\.colorScheme, .dark)

        )
    }
}
