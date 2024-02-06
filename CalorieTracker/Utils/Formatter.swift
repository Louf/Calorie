//
//  Formatter.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 2/6/24.
//

import Foundation

var formatterInput: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    return formatter
}
