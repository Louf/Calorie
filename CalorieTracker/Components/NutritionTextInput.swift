//
//  NutritionInput.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 2/1/24.
//

import SwiftUI

struct NutritionTextInput: View {
    
    @Binding var value: String
    let textSize: CGFloat
    
    var body: some View {
        HStack(alignment: .bottom) {
            TextField("Food Name", text: $value.max(18))
                .font(.system(size: textSize, weight: .bold))
                .keyboardType(.numberPad) // Show number pad keyboard
                .fixedSize(horizontal: true, vertical: false)
                .placeholder(when: value.isEmpty) {
                    Text("Food Name")
                        .font(.system(size: textSize, weight: .bold))
                        .selfSizeMask(
                            LinearGradient(
                                gradient: Gradient(colors: [.cyan.opacity(0.5), .pink.opacity(0.3)]),
                                startPoint: .leading,
                                endPoint: .trailing)
                        )
                }
        }
    }
}

struct NutritionMultiTextInput: View {
    
    @Binding var value: String
    let textSize: CGFloat
    
    var body: some View {
        VStack {
            TextEditor(text: $value)
                .font(.system(size: textSize, weight: .bold))
                .keyboardType(.default) // Use default keyboard instead of number pad for text input
                .frame(height: textSize * 5) // Adjust the height based on your textSize * number of lines
                .overlay(
                    RoundedRectangle(cornerRadius: 15) // Adjust cornerRadius as needed
                        .stroke(.ultraThinMaterial, lineWidth: 3) // Black outline with a 1 point stroke width
                        .environment(\.colorScheme, .dark)

                )
                .scrollContentBackground(.hidden) // <- Hide it
                .background(.clear) // To see this
        }
    }
}

