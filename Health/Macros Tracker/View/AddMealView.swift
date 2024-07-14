//
//  AddMeadView.swift
//  Health
//
//  Created by Saransh Singhal on 24/06/24.
//

import SwiftUI

struct AddMealView: View {
    @State var addMeal : (String, Date) -> Void
    @State var food : String = ""
    @State private var date : Date = Date()
    var body: some View {
        VStack{
            Text("Add your Meals")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("What did you eat",text: $food)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke()
                )
            
            DatePicker("Date", selection: $date)
                .padding()
            
            Button {
               addMeal(food, date)
            }
        label:{
            Text("Add")
                .font(.title3)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding()
                .frame(maxWidth: .infinity)
                
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(.black)
                    
                )
                
                
                
            
        }
        }
        .padding()
    }
}

#Preview {
    AddMealView {_, _ in 
        
    }
}
