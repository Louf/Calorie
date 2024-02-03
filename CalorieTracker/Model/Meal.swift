//
//  Meal.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 1/30/24.
//

import SwiftData
import SwiftUI

@Model
class Meal {
    private (set) var mealID: String = UUID().uuidString
    var name: String
    var recipes: [Recipe]
    var foodItems: [FoodItem]
    var date: Date
    var notes: String

    init(mealID: String, name: String, recipes: [Recipe], foodItems: [FoodItem], date: Date, notes: String) {
        self.mealID = mealID
        self.name = name
        self.recipes = recipes
        self.foodItems = foodItems
        self.date = date
        self.notes = notes
    }
}
