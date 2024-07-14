//
//  Micro.swift
//  Health
//
//  Created by Saransh Singhal on 23/06/24.
//

import Foundation
import SwiftData

@Model
final class Micro{
   
    let food : String
    let createdAt : Date
    let date : String
    let carbs : Int
    let protein : Int
    let fats : Int
    let calories: Double
    let servingSizeG: Int
    let saturatedFat: Double
    let sodiumMg :Int
    let potassiumMg : Int
    let cholesterolMg: Int
    let fiberG: Double
    let sugarG: Double
    
    init(food: String, createdAt: Date, date: String, carbs: Int, protein: Int, fats: Int, calories: Double, servingSizeG: Int, saturatedFat: Double, sodiumMg: Int, potassiumMg: Int, cholesterolMg: Int, fiberG: Double, sugarG: Double) {
        
        self.food = food
        self.createdAt = createdAt
        self.date = date
        self.carbs = carbs
        self.protein = protein
        self.fats = fats
        self.calories = calories
        self.servingSizeG = servingSizeG
        self.saturatedFat = saturatedFat
        self.sodiumMg = sodiumMg
        self.potassiumMg = potassiumMg
        self.cholesterolMg = cholesterolMg
        self.fiberG = fiberG
        self.sugarG = sugarG
    }
}
