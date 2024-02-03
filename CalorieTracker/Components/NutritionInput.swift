//
//  NutritionInput.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 2/1/24.
//

import SwiftUI

struct NutritionInput: View {
    
    @Binding var value: String
    let title: String
    
    var body: some View {
        HStack(alignment: .bottom) {
            TextField("0000", text: $value.max(4))
                .font(.system(size: 56, weight: .bold))
                .keyboardType(.numberPad) // Show number pad keyboard
                .fixedSize(horizontal: true, vertical: false)
                .placeholder(when: value.isEmpty) {
                    Text("0000")
                        .font(.system(size: 56, weight: .bold))
                        .selfSizeMask(
                            LinearGradient(
                                gradient: Gradient(colors: [.cyan.opacity(0.5), .pink.opacity(0.3)]),
                                startPoint: .leading,
                                endPoint: .trailing)
                        )
                }
            
            Text(title)
                .font(.system(size: 32, weight: .bold))
                .padding(.bottom, 10)
        }
    }
}
