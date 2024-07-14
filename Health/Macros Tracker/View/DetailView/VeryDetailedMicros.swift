//
//  VeryDetailedMicros.swift
//  Health
//
//  Created by Saransh Singhal on 27/06/24.
//

import SwiftUI


struct VeryDetailedMicros: View {
    
    @State var micro : Micro
    

    var body: some View {
        NavigationStack{
            VStack(content: {
                
                    List{
                        detailedTab(title: "Serving Size", value: "\(micro.servingSizeG)g")
                        detailedTab(title: "Calories", value: "\(micro.calories)g")
                        detailedTab(title: "Carbohydrates", value: "\(micro.carbs)")
                        detailedTab(title: "Protein", value: "\(micro.protein)")
                        detailedTab(title: "Fats", value: "\(micro.fats)")
                        detailedTab(title: "Saturated Fats", value: "\(micro.saturatedFat)")
                        detailedTab(title: "Sodium", value: "\(micro.sodiumMg)mg")
                        detailedTab(title: "Potassium", value: "\(micro.potassiumMg)mg")
                        detailedTab(title: "Cholestrol", value: "\(micro.cholesterolMg)mg")
                        detailedTab(title: "Fiber", value: "\(micro.fiberG)g")
                        detailedTab(title: "Sugar", value: "\(micro.sugarG)g")
                        
                    }
                
            })
        }
        .navigationTitle(micro.food)
    }
}

#Preview {
    VeryDetailedMicros(micro: Micro(food: "Milk", createdAt: .now, date: "Jun 12 2024", carbs: 10, protein: 10, fats: 10, calories: 10, servingSizeG: 10, saturatedFat: 10, sodiumMg: 10, potassiumMg: 10, cholesterolMg: 10, fiberG: 10, sugarG: 10))
        
}
