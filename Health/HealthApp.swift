//
//  HealthApp.swift
//  Health
//
//  Created by Saransh Singhal on 13/06/24.
//

import SwiftUI
import SwiftData

@main
struct HealthApp: App {
    
    
    
    
    
    
    @StateObject var manager = HealthManager()
    
    var sharedModelContainer : ModelContainer = {
        let schema = Schema([
            Micro.self,
            UserCalories.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema : schema, isStoredInMemoryOnly: false)
        
        do{
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        }
        catch{
            fatalError("Could not find : \(error)")
        }
    }()
    

    
    var body: some Scene {
        WindowGroup {
            beActiveTabView()
                .environmentObject(manager)
                .modelContainer(sharedModelContainer)
                
        }
       
    }
}

