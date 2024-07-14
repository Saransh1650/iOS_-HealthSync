//
//  MicroItemView.swift
//  Health
//
//  Created by Saransh Singhal on 18/06/24.
//

import SwiftUI

struct MicroHeaderView: View {
    
    @Binding var carbs : Int
    @Binding var fats : Int
    @Binding var protein : Int
    
    @Binding var calories : Int
    
    
    @Binding var caloriMax : Int
    @Binding var proMax : Int
    @Binding var carbMax : Int
    @Binding var fatsMax : Int
    
    func Calories(){
        calories = (carbs * 4) + (fats * 9) + (protein * 4)
         }
    
    var body: some View {
        
        VStack{
            HStack{
                Spacer()
                Text("\(calories)")
                    .padding()
                    .font(.system(size: 45, design: .monospaced))
                    .bold()
                    .contentTransition(.numericText())
                    .foregroundStyle(.white)
                    
                Spacer()
                
                VStack{
                    HStack{
                        Gauge(value: Float(protein),in: 0...Float(proMax), label: {
                            
                        }
                        )
                        .gaugeStyle(.accessoryCircular)
                        .scaleEffect(1.2)
                        .tint(.red)
                        .padding(.leading)
                    }
                    HStack{
                        Gauge(value:Float(carbs),in: 0...Float(carbMax), label: {
                           
                        }
                        )
                        .gaugeStyle(.accessoryCircular)
                        .scaleEffect(1.2)
                        .padding(.horizontal)
                        .tint(.green)
                        
                        Gauge(value: Float(fats),in: 0...Float(fatsMax), label: {
                           
                        }
                        )
                        .gaugeStyle(.accessoryCircular)
                        .scaleEffect(1.2)
                        
                        .tint(.blue)
                    }
                }
                Spacer()
                
            }
            HStack(){
                Gauge(value: Double(calories),in: 0...Double(caloriMax) , label: {
                  
                }
                )
                
                .tint(.mint)
            }
            
            
            
            
        }
        .onAppear(){
            withAnimation(){
                Calories()
            }
        }
    }
}

#Preview {
    MicroHeaderView(carbs: .constant(20), fats: .constant(20), protein: .constant(20), calories: .constant(10), caloriMax: .constant(2000), proMax: .constant(20), carbMax: .constant(20) , fatsMax: .constant(20))
}
