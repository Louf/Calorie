//
//  FoodItem.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 1/30/24.
//

import SwiftUI
import SwiftData

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
    private(set) var foodID: String = UUID().uuidString
    var name: String
    var calories: Int
//    var unit: FoodUnit // Use FoodUnit directly as the unit type
    var unitAmount: Int
    var protein: Int
    var fat: Int
    var carbs: Int
    var notes: String

    var unitString: String
    
    //Need a getter and setter here so that we can fetch and set a new value
    var unit: FoodUnit {
        get { FoodUnit(rawValue: unitString) ?? .grams } // Fallback to .gram if rawValue is not valid
        set { unitString = newValue.rawValue }
    }

    init(foodID: String = UUID().uuidString, name: String, calories: Int, unit: FoodUnit, unitAmount: Int, protein: Int, fat: Int, carbs: Int, notes: String) {
        self.foodID = foodID
        self.name = name
        self.calories = calories
        self.unitString = unit.rawValue
        self.unitAmount = unitAmount
        self.protein = protein
        self.fat = fat
        self.carbs = carbs
        self.notes = notes
    }
}
