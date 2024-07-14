//
//  HomeView.swift
//  Health
//
//  Created by Saransh Singhal on 13/06/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var manager : HealthManager
    let welcomeArray = ["Welcome","Bienvenido", "Bienvenue"]
    @State private var currentIndex = 0
    
    var body: some View {
        VStack(alignment : .leading){
            Text(welcomeArray[currentIndex])
                .font(.title)
                .animation(.interactiveSpring(duration: 1), value: currentIndex)
                .onAppear{
                        startWelcomeTimer()
                }
                .foregroundColor(.secondary)
                .fontWeight(.bold)
            
            LazyVGrid(columns: Array (repeating: GridItem(spacing: 20), count: 2), content: {
                ForEach(manager.activity.sorted(by: {$0.value.id < $1.value.id}), id: \.key){
                    item in
                    ActivityCard(activity: item.value) 
                }
            })
            
        }
       
        
        
        .padding()
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.orange.opacity(0.8), Color.white]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
        .onAppear{
            manager.fetchTodaysData()
            manager.fetchTodaysCalories()
            manager.fetchWeekRunning()
            manager.fetchWeightLiftingStats()
            manager.fetchBasketBallStats()
            manager.fetchSoccerStats()
            manager.fetchStairsStats()
            manager.fetchSwimmingStats()
           
        }
        
        
    }
    
    func startWelcomeTimer() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true){ _ in
            
            withAnimation{
                
            }

        }
        
    }
        
}

#Preview {
    
    HomeView()
        .environmentObject(HealthManager())
}
