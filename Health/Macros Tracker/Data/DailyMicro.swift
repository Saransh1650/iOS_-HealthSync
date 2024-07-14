//
//  DailyMicro.swift
//  Health
//
//  Created by Saransh Singhal on 24/06/24.
//

import Foundation

struct DailyMicro : Identifiable{
    let date : String
    let id = UUID()
    let carbs : Int
    let protein : Int
    let fats : Int
}
