//
//  FoodEntry.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 1/30/24.
//

import SwiftData
import SwiftUI

@Model
class FoodEntry {
    private (set) var foodID: String = UUID().uuidString
    var foodItem: FoodItem
    var quantity: Int
    var date: Date
    
    
    init(foodID: String, foodItem: FoodItem, quantity: Int, date: Date) {
        self.foodID = foodID
        self.foodItem = foodItem
        self.quantity = quantity
        self.date = date
    }
}
