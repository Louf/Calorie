import SwiftUI
import SwiftData

@Model
class Recipe {
    private (set) var recipeID: String = UUID().uuidString
    var name: String
    var servings: Int
    var notes: String
    var ingredients: [FoodItem]

    init(recipeID: String = UUID().uuidString, name: String, ingredients: [FoodItem], servings: Int, notes: String) {
        self.recipeID = recipeID
        self.name = name
        self.servings = servings
        self.notes = notes
        self.ingredients = ingredients // Initialize with provided ingredients
    }

    // Function to calculate all nutritional totals
    func calculateAllTotals() -> NutritionalTotals {
        let totals = ingredients.reduce(NutritionalTotals(calories: 0, protein: 0, fat: 0, carbs: 0)) { (totals, ingredient) in
            return NutritionalTotals(
                calories: totals.calories + ingredient.calories,
                protein: totals.protein + ingredient.protein,
                fat: totals.fat + ingredient.fat,
                carbs: totals.carbs + ingredient.carbs
            )
        }
        return totals
    }

    // Properties to access the calculated totals
    var totalCalories: Int { calculateAllTotals().calories }
    var totalProtein: Int { calculateAllTotals().protein }
    var totalFat: Int { calculateAllTotals().fat }
    var totalCarbs: Int { calculateAllTotals().carbs }
    
    struct NutritionalTotals {
        var calories: Int
        var protein: Int
        var fat: Int
        var carbs: Int
    }
}
