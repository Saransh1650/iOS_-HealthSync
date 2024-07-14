//
//  MicroDayView.swift
//  Health
//
//  Created by Saransh Singhal on 25/06/24.
//

import SwiftUI

struct MicroDayView: View {
    @State var micro : DailyMicro
    var body: some View {
        VStack(){
            HStack{
                Text("\(micro.date)")
                    .bold()
                    .font(.title3)
                    .foregroundStyle(.black)
                Spacer()
            }
            HStack{
                Text("\(micro.carbs)g")
                    .foregroundStyle(.green)
                    .font(.title3)
                Spacer()
                Text("\(micro.fats)g")
                    .foregroundStyle(.blue)
                    .font(.title3)
                Spacer()
                Text("\(micro.protein)g")
                    .foregroundStyle(.red)
                    .font(.title3)
                
                Spacer()
                
                Text("\((micro.carbs * 4) + (micro.protein * 4) + (micro.fats * 9)) Kcal")
                    .font(.title3)
                    .foregroundStyle(.cyan)
            }
            
            
            
        }
        .padding()
        
        
    }
}

#Preview {
    MicroDayView(micro: DailyMicro(date: Calendar.current.startOfDay(for: .now).formatted(date: .complete, time: .omitted), carbs: 12, protein: 23, fats: 21))
}
