//
//  detailedTab.swift
//  Health
//
//  Created by Saransh Singhal on 01/07/24.
//

import SwiftUI

struct detailedTab: View {
    @State var title : String
    @State var value : String
    var body: some View {
        HStack{
            Text("\(title)")
                .fontWeight(.bold)
                .font(.title2)
            
            Spacer()
            Text("\(value)")
                .font(.title3)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    detailedTab(title: "title", value: "title")
}
