//
//  ChartView.swift
//  Health
//
//  Created by Saransh Singhal on 16/06/24.
//

import SwiftUI
import Charts

struct DailyStepView : Identifiable{
    let id = UUID()
    let date : Date
    let stepCount : Double
}

enum
ChartOptions {
case
    oneWeek
case
    oneMonth
case
    threeMonth
case
    yearToDate
case
    oneYear
}

struct ChartView: View {
    @EnvironmentObject var manager : HealthManager
    @State var selectedChart : ChartOptions = .oneMonth
    var body: some View {
        VStack{
            Chart{
                ForEach(manager.oneMonthStepData){daily in
                    BarMark(x: .value(daily.date.formatted(), daily.date, unit: .day), y: .value("Steps", daily.stepCount))
                }
                
            }
            .frame(height: 350)
            .padding(.horizontal)
            
            HStack{
                Button ("1W"){
                    withAnimation(){
                        selectedChart = .oneWeek
                    }
            }
                .padding(.all)
                .foregroundColor(selectedChart ==
                    .oneWeek ? .white : .green)
                .background (selectedChart == .oneWeek ? .green : .clear)
                .cornerRadius (10)
                
                Button ("1M"){
                    withAnimation(.bouncy){
                        selectedChart = .oneMonth
                    }
                }
                .padding(.all)
                .foregroundColor(selectedChart ==
                    .oneMonth ? .white : .green)
                .background (selectedChart == .oneMonth ? .green : .clear)
                .cornerRadius (10)
                Button ("3M"){
                    withAnimation(){
                        selectedChart = .threeMonth
                    }
            }
                .padding(.all)
                .foregroundColor(selectedChart ==
                    .threeMonth ? .white : .green)
                .background (selectedChart == .threeMonth ? .green : .clear)
                .cornerRadius (10)
                Button ("YTD"){
                    withAnimation(){
                        selectedChart = .yearToDate
                    }
            }
                .padding(.all)
                .foregroundColor(selectedChart ==
                    .yearToDate ? .white : .green)
                .background (selectedChart == .yearToDate ? .green : .clear)
                .cornerRadius (10)
                Button ("1Y"){
                    withAnimation(.bouncy){
                        selectedChart = .oneYear
                    }
            }
                .padding(.all)
                .foregroundColor(selectedChart ==
                    .oneYear ? .white : .green)
                .background (selectedChart == .oneYear ? .green : .clear)
                .cornerRadius (10)
                
            }
        }
    }
}

#Preview {
    ChartView()
        .environmentObject(HealthManager())
}
