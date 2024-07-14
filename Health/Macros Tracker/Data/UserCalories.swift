//
//  UserCalories.swift
//  Health
//
//  Created by Saransh Singhal on 01/07/24.
//

import Foundation
import SwiftData

@Model
final class UserCalories {
    let calories : Int
    let carbs : Int
    let protein : Int
    let fats : Int
    
    init(calories: Int, carbs: Int, protein: Int, fats: Int) {
        self.calories = calories
        self.carbs = carbs
        self.protein = protein
        self.fats = fats
    }
}
