//
//  DetailView.swift
//  Health
//
//  Created by Saransh Singhal on 27/06/24.
//

import SwiftUI

struct DetailViewItem: View {
    
    @State var title : String
    @State var calories : Int
    var body: some View {
       
            
                VStack{
                    HStack(content: {
                        VStack(content: {
                            Text("\(title)")
                                .font(.title2)
                                .fontWeight(.bold)
                                
                            
                        })
                        
                        Spacer()
                        
                        Text("\(calories) Kcal")
                            .font(.title2)
                            .foregroundStyle(.gray)
                    })
                
                
            
        }
                .padding()
    }
}

#Preview {
    DetailViewItem(title: "", calories: 0)
}
