import SwiftUI
import SwiftData

struct HomeScreenView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var bannerManager: BannerManager
    
    @State private var foodEntryShow = false
    @State private var currentDate = Date() // Add state for tracking current date
    
    @State private var showingDatePicker = false // New state for managing DatePicker visibility
    
    @State private var foodEntriesForCurrentDate: [FoodEntry] = [] // State for filtered entries

    
    // It's just FoodItem for now
    @Query(sort: [SortDescriptor(\FoodEntry.date, order: .reverse)], animation: .snappy) private var allFoodEntries: [FoodEntry]
    
    private func filterFoodEntriesForCurrentDate() {
        foodEntriesForCurrentDate = allFoodEntries.filter { Calendar.current.isDate($0.date, inSameDayAs: currentDate) }
    }
    
    var totalFat: Int {
        var totalFat = 0
        for entry in foodEntriesForCurrentDate {
            totalFat += entry.foodItem.fat * entry.quantity
        }
        return totalFat
    }
    var totalCarbs: Int {
        var totalCarbs = 0
        for entry in foodEntriesForCurrentDate {
            totalCarbs += entry.foodItem.carbs * entry.quantity
        }
        return totalCarbs
    }
    var totalProtein: Int {
        var totalProtein = 0
        for entry in foodEntriesForCurrentDate {
            totalProtein += entry.foodItem.protein * entry.quantity
        }
        return totalProtein
    }
    var totalCalories: Int {
        var totalCalories = 0
        for entry in foodEntriesForCurrentDate {
            totalCalories += entry.foodItem.calories * entry.quantity
        }
        return totalCalories
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    // Left arrow for previous day
                    Button {
                        moveDay(by: -1)
                    } label: {
                        Image(systemName: "arrow.left.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    // Show current date instead of always today's date
                    Button {
                        showingDatePicker = true
                    } label: {
                        Text(currentDate, style: .date)
                            .font(.title2.bold())
                    }
                    .overlay{ //Place the DatePicker in the overlay extension
                       DatePicker(
                           "",
                           selection: $currentDate,
                           displayedComponents: [.date]
                       )
                        .blendMode(.destinationOver) //Use this extension to keep the clickable functionality
                    }

                    
                    
                    Spacer()
                    
                    // Right arrow for next day
                    Button {
                        moveDay(by: 1)
                    } label: {
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.black)
                    }
                    
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
                
                ScrollView {
                    ForEach($foodEntriesForCurrentDate) { foodEntry in
                        FoodCard(foodItem: foodEntry.foodItem)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 355)
                
                if !foodEntriesForCurrentDate.isEmpty {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(totalProtein)g")
                                .font(.system(size: 26, weight: .bold))
                            Text("Protein")
                        }
                        Spacer()
                        VStack(alignment: .center) {
                            Text("\(totalFat)g")
                                .font(.system(size: 26, weight: .bold))
                            Text("Fat")
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("\(totalCarbs)g")
                                .font(.system(size: 26, weight: .bold))
                            Text("Carbs")
                        }
                    }
                    .font(.subheadline)
                    
                    VStack(alignment: .trailing) {
                        Text("\(totalCalories)")
                            .font(.system(size: 32, weight: .bold))
                        Text("Cal")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Spacer()
                
            }
            .padding()
            .navigationBarTitle("Welcome back", displayMode: .large)
            .navigationBarTitleDisplayMode(.inline)
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .fullScreenCover(isPresented: $foodEntryShow) {
            NewFoodEntryView()
                .interactiveDismissDisabled()
        }
        .onChange(of: currentDate) {
            filterFoodEntriesForCurrentDate()
        }
        .onChange(of: allFoodEntries) {
            filterFoodEntriesForCurrentDate()
        }
        .onAppear {
            filterFoodEntriesForCurrentDate()
        }
    }
    
    // Function to move the day by a given amount
    private func moveDay(by dayOffset: Int) {
        guard let newDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate) else { return }
        currentDate = newDate
    }
}
