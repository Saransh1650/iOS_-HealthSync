//
//  MicrosData.swift
//  Health
//
//  Created by Saransh Singhal on 22/06/24.
//

import Foundation

struct MicrosData : Codable{
    let items : [items]
}

struct items : Codable{
        let name: String
        let calories: Double
        let servingSizeG: Int
        let fatTotalG, fatSaturatedG, proteinG: Double
        let sodiumMg, potassiumMg, cholesterolMg: Int
        let carbohydratesTotalG: Double
        let fiberG: Double
        let sugarG: Double
    
    enum CodingKeys: String, CodingKey {
            case name = "name"
            case calories = "calories"
            case servingSizeG = "serving_size_g"
            case fatTotalG = "fat_total_g"
            case fatSaturatedG = "fat_saturated_g"
            case proteinG = "protein_g"
            case sodiumMg = "sodium_mg"
            case potassiumMg = "potassium_mg"
            case cholesterolMg = "cholesterol_mg"
            case carbohydratesTotalG = "carbohydrates_total_g"
            case fiberG = "fiber_g"
            case sugarG = "sugar_g"
        }
        
    
}
