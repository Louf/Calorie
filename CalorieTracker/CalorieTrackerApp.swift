import SwiftUI
import SwiftData

@main
struct CalorieTrackerApp: App {
    var bannerManager = BannerManager()
    
    let modelContainer: ModelContainer
        
    init() {
            do {
                modelContainer = try ModelContainer(for: FoodItem.self, FoodEntry.self, Recipe.self, Meal.self)
            } catch {
                fatalError("Could not initialize ModelContainer")
            }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bannerManager)
        }
        .modelContainer(modelContainer)
        
    }
}
