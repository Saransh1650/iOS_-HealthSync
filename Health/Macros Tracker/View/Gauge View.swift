//
//  Gauge View.swift
//  Health
//
//  Created by Saransh Singhal on 01/07/24.
//

import SwiftUI

struct Gauge_View: View {
    @State private var current = 67.0
        @State private var minValue = 50.0
        @State private var maxValue = 170.0
        let gradient = Gradient(colors: [.green, .yellow, .orange, .red])


    var body: some View {
        VStack{
            
               
                    Gauge(value: current, in: minValue...maxValue) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    } currentValueLabel: {
                        Text("\(Int(current))")
                            .foregroundColor(Color.green)
                    } minimumValueLabel: {
                        Text("\(Int(minValue))")
                            .foregroundColor(Color.green)
                    } maximumValueLabel: {
                        Text("\(Int(maxValue))")
                            .foregroundColor(Color.red)
                    }
                    .frame(width: 200 ,height: 200)
                    .gaugeStyle(.accessoryCircularCapacity)
                    
                }
                
                
                
            
        
    }
}

#Preview {
    Gauge_View()
}
