//
//  HomeScreen.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 1/30/24.
//

import SwiftUI
import SwiftData

struct HomeScreenView: View {
    
    @Environment(\.modelContext) private var context
    
    @EnvironmentObject var bannerManager: BannerManager
    
    //ITS JUST FOODITEM FOR NOW
    @Query(sort: [SortDescriptor(\FoodItem.name, order: .reverse)], animation: .snappy) private var allFoodEntries: [FoodItem]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Welcome back, Louis")
                    
                    .font(.title.bold())
                
                Text(Date(), style: .date)
                    .font(.title2)
                
                ForEach(allFoodEntries) { entry in
                    Text(entry.name)
                }
                
                Button("Show Banner") {
                    bannerManager.displayBanner(image: "carrot.fill", message: "This is a custom banner notification.")
                }
            }
            .foregroundStyle(.black)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    HomeScreenView()
}
