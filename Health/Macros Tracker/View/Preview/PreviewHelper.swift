//
//  SwiftUIView.swift
//  Health
//
//  Created by Saransh Singhal on 01/07/24.
//

import SwiftUI
import SwiftData
struct PreviewHelpers {
    static func mockMicroData() -> [Micro] {
        return [Micro(food: "", createdAt: .now, date: "", carbs: 0, protein: 0, fats: 0, calories: 0.0, servingSizeG: 0, saturatedFat: 0, sodiumMg: 0, potassiumMg: 0, cholesterolMg: 0, fiberG: 0, sugarG: 0)]
    }
    
    static func mockModelContainer() -> ModelContainer {
        let mockSchema = Schema([Micro.self, UserCalories.self])
        let mockConfiguration = ModelConfiguration(schema: mockSchema, isStoredInMemoryOnly: true)
        
        do {
            return try ModelContainer(for: mockSchema, configurations: [mockConfiguration])
        } catch {
            fatalError("Could not initialize mock ModelContainer: \(error.localizedDescription)")
        }
    }
}
