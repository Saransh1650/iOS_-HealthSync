//
//  beActiveTabView.swift
//  Health
//
//  Created by Saransh Singhal on 13/06/24.
//

import SwiftUI
import SwiftData

struct beActiveTabView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var manager : HealthManager
    @State var selectedTab : String = "Home"
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag("Home")
                .tabItem {
                    Image(systemName: "house")
                }
              MacroView(dataFetcher: NutritionAPi())
                .tag("Macros")
                .tabItem {
                    Image(systemName: "fork.knife.circle.fill")
                }
        }
    }
}

#Preview {
   
   beActiveTabView()
        .environmentObject(HealthManager())
        .modelContainer(PreviewHelpers.mockModelContainer())
     
}
