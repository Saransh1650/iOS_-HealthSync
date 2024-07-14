//
//  ChangeCalorieTarget.swift
//  Health
//
//  Created by Saransh Singhal on 01/07/24.
//

import SwiftUI

struct CalorieTarget: View {
    @Environment(\.modelContext) var modelContext
    @State var calorieIntake: Int? = 0
    @State var carbs : String = ""
    @State var protein : String = ""
    @State var fats : String = ""
    
        
    
    func changeCalories(carbs : Int, fats : Int, protein : Int){
       
            calorieIntake = (carbs * 4) + (protein * 4) + (fats * 9)
    }
    
    func saveCalories(calories : Int, carbs : Int, fats : Int, protein : Int) {
        let calories = UserCalories(calories: calories, carbs: carbs, protein: protein, fats: fats)
        print(calories)
        do{
            modelContext.insert(calories)
            try modelContext.save()
        }
        catch{
            print(error.localizedDescription)
        }
    }
        
        var body: some View {
            VStack {
                Text("Enter your daily Macros intake")
                    .font(.title2)
                    .bold()
                
                
        
                
                TextField("Carbohydrates", text: $carbs)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                TextField("Fats", text: $fats)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                TextField("Protein", text: $protein)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
              HStack { Text("Estimated Calories  :: \(calorieIntake ?? 0)")
                    .contentTransition(.numericText())
                  
                  Spacer()
                  
                  Button(action: {
                      withAnimation(){
                          changeCalories(carbs: Int(carbs) ?? 0, fats: Int(fats) ?? 0, protein: Int(protein) ?? 0)
                      }
                  }, label: {
                      Text("Calculate Calories")
                  })
               }
                
                
                               
                Button("Save") {
                    saveCalories(calories: calorieIntake ?? 0, carbs: Int(carbs) ?? 0, fats: Int(fats) ?? 0, protein: Int(protein) ?? 0)
                    
                    print(calorieIntake)
                    print(carbs)
                    print(protein)
                    print(fats)
                }
                .padding()
            }
            .padding()
           
        }
    }

#Preview {
    CalorieTarget()
    .modelContainer(PreviewHelpers.mockModelContainer())
}
