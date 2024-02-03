//
//  FoodLibraryView.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 1/30/24.
//

import SwiftUI

struct FoodLibraryView: View {
    var body: some View {
        ZStack {
            Color.white
            
            //All content goes here in front of white view
            Text("Food Library")
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    FoodLibraryView()
}
