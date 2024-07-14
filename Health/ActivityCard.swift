//
//  ActivityCard.swift
//  Health
//
//  Created by Saransh Singhal on 13/06/24.
//

import SwiftUI

struct Activity {
    let id : Int
    let title: String
    let subTitle : String
    let tint : Color
    let amount : String
    let image : String
}

struct ActivityCard: View {
    @State var activity : Activity
    var body: some View {
        VStack(){
            HStack(alignment:.top){
                VStack(alignment:.leading) {
                    Text(activity.title)
                        .font(.system(size: 16))
                    Text(activity.subTitle)
                        .font(.system(size: 12))
                }
                
                Spacer()
                
                Image(systemName: activity.image)
                    .foregroundColor(activity.tint)
            }.padding()
            
            Text(activity.amount)
                .font(.system(size: 24))
        }
        .padding(.bottom)
        
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    ActivityCard(activity: Activity(id: 1, title: "Daily Steps", subTitle: "Goal : 1000",tint: .blue, amount: "2398", image: "figure.walk"))
}
