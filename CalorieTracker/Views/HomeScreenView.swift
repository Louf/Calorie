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
    
    @State private var foodEntryShow = false
    
    //ITS JUST FOODITEM FOR NOW
    @Query(sort: [SortDescriptor(\FoodEntry.date, order: .reverse)], animation: .snappy) private var allFoodEntries: [FoodEntry]
    
    //Filter the results here
    //Do not try to filter inside the query, much harder, though would be cleaner if I could get it to work
    var foodEntriesToday: [FoodEntry] {
        return allFoodEntries.filter({ Calendar.current.isDateInToday($0.date) })
    }
    
//    init() {
//        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 24)!]
//    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text(Date(), style: .date)
                            .font(.title2.bold())
                        Spacer()
                        Button {
                            foodEntryShow.toggle()
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: 48, height: 48)
                                    .shadow(radius: 4)
                                
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(Color(.black))
                            }
                        }
                    }
                    
                    ForEach(foodEntriesToday) { foodEntry in
                        Text(foodEntry.foodItem.name)
                    }
                }
                .padding()
            }
            .navigationBarTitle("Welcome back", displayMode: .large)
            .navigationBarTitleDisplayMode(.inline)
            .foregroundStyle(.black)
//            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .fullScreenCover(isPresented: $foodEntryShow) {
            NewFoodEntryView()
                .interactiveDismissDisabled()
        }
    }
}
