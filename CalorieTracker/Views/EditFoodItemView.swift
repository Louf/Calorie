//
//  EditFoodItem.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 2/6/24.
//

import SwiftUI

struct EditFoodItemView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var bannerManager: BannerManager
    
    @Binding var foodItem: FoodItem
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom){
                List {
                    Section("Calories") {
                        TextField("Name", text: $foodItem.name)
                            .font(.title.bold())
                    }
                    
                    Section("Calories") {
                        TextField("0.0", value: $foodItem.calories, formatter: formatterInput)
                            .keyboardType(.numberPad)
                            .font(.title.bold())
                    }
                    
                    Section("Protein") {
                        TextField("0.0", value: $foodItem.protein, formatter: formatterInput)
                            .keyboardType(.numberPad)
                            .font(.title.bold())
                    }
                    
                    Section("Fat") {
                        TextField("0.0", value: $foodItem.fat, formatter: formatterInput)
                            .keyboardType(.numberPad)
                            .font(.title.bold())
                    }
                    
//                    Section("Date") {
//                        DatePicker("", selection: $expense.date, displayedComponents: [.date])
//                            .datePickerStyle(.graphical)
//                            .labelsHidden()
//                            .padding(.bottom, 56)
//                    }
                    
                    
                }
                .environment(\.defaultMinListRowHeight, 20)
                .navigationTitle("Edit Food Item")
                
                
                
                Button {
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .font(.headline.bold())
                        .foregroundStyle(.white)
                        .background(isAddButtonDisabled ? AnyShapeStyle(.gray.gradient) : AnyShapeStyle(.blue.gradient), in: .capsule)
                        .padding()
                }
                .disabled(isAddButtonDisabled)
            }
        }
        .presentationCornerRadius(20)
        .interactiveDismissDisabled()
    }
    
    var isAddButtonDisabled: Bool {
        return foodItem.unitAmount <= 0 || foodItem.name.isEmpty || foodItem.calories <= 0
    }
}
