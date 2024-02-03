//
//  FoodItem.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 1/30/24.
//

import SwiftUI
import SwiftData

@Model
class FoodItem {
    private (set) var foodID: String = UUID().uuidString
    var name: String
    var calories: Int
    var unitRaw: String
    var unitAmount: Int
    
    //Will always be in grams
    var protein: Int
    var fat: Int
    var carbs: Int
    
    //Any notes they may want to add for the food item
    var notes: String
    
    var unit: Unit {
        get { Unit(rawValue: unitRaw) ?? .gram } // Fallback to .gram if rawValue is not valid
        set { unitRaw = newValue.rawValue }
    }
    
    init(foodID: String = UUID().uuidString, name: String, calories: Int, unit: Unit, unitAmount: Int, protein: Int, fat: Int, carbs: Int, notes: String) {
        self.foodID = foodID
        self.name = name
        self.calories = calories
        self.unitRaw = unit.rawValue // Initialize with the raw value of the unit
        self.unitAmount = unitAmount
        self.protein = protein
        self.fat = fat
        self.carbs = carbs
        self.notes = notes
    }
}
