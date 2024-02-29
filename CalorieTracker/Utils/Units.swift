import Foundation

enum FoodUnit: String, CaseIterable, Identifiable {
    case grams = "g"
    case pounds = "lbs"
    case cups = "cups"
    case tablespoons = "tbsp"
    case teaspoons = "tsp"
    case ounces = "oz"
    
    var id: String { self.rawValue }
}
