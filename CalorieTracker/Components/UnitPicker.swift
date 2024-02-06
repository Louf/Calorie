//
//  UnitPicker.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 2/4/24.
//

import SwiftUI



struct UnitPicker: View {
    @Binding var selectedUnit: FoodUnit
    @Binding var unitAmount: String

    var body: some View {
        HStack {
            HStack {
                HStack(alignment: .bottom) {
                    Text("Amount")
                        .font(.system(size: 16, weight: .bold))
                        .padding(.bottom, 10)
                    Spacer()
                    TextField("0000", text: $unitAmount.max(4))
                        .font(.system(size: 32, weight: .bold))
                        .keyboardType(.numberPad) // Show number pad keyboard
                        .fixedSize(horizontal: true, vertical: false)
                        .placeholder(when: unitAmount.isEmpty) {
                            Text("0000")
                                .font(.system(size: 32, weight: .bold))
                                .selfSizeMask(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.cyan.opacity(0.5), .pink.opacity(0.3)]),
                                        startPoint: .leading,
                                        endPoint: .trailing)
                                )
                        }
                    
                }
            }
            
            HStack {
                Text("Unit:")
                    .font(.headline)
                Spacer()
                Picker("Select a food unit", selection: $selectedUnit) {
                    ForEach(FoodUnit.allCases) { unit in
                        Text(unit.rawValue).tag(unit)
                            .foregroundStyle(.white)
                    }
                }
                .tint(.white)
                .background(.ultraThinMaterial)
                .environment(\.colorScheme, .dark)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .pickerStyle(MenuPickerStyle()) // Explicitly set the picker style to Menu

            }
            .padding()
        }
    }
}
