//
//  MacroDetailedView.swift
//  Health
//
//  Created by Saransh Singhal on 27/06/24.
//

import SwiftUI
import SwiftData
struct MacroDetailedView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State var micro : DailyMicro
    
    @Query private var filteredData: [Micro]
    
    @State var data : [Micro] = [Micro(food: "", createdAt: .now, date: "", carbs: 0, protein: 0, fats: 0, calories: 0.0, servingSizeG: 0, saturatedFat: 0, sodiumMg: 0, potassiumMg: 0, cholesterolMg: 0, fiberG: 0, sugarG: 0)]
    
    func getdata(){
        let filteredDate = micro.date
        let descriptor = FetchDescriptor<Micro>(
            predicate: #Predicate { $0.date == filteredDate },
            sortBy: [
                .init(\.createdAt)
            ]
        )
        do{
            let data = try modelContext.fetch(descriptor)
             print(data)
            print(filteredDate)
            self.data = data
            
         }
        catch{
            print(error.localizedDescription)
        }
        
    }
    
    
    var body: some View {
        
            NavigationStack{
                VStack{
                   
                    List(data, id: \.self) { micro in
                        
                        NavigationLink {
                            VeryDetailedMicros(micro: micro)
                        } label: {
                            DetailViewItem(title: "\(micro.food)", calories: ((micro.carbs * 4) + (micro.protein * 4) + (micro.fats * 9)))
                        }

                        
                       
                    }
                  
                }
            }
            .navigationTitle(micro.date)
            .onAppear(){
               
//            filterData(date: getDate())
                getdata()
               
//
        }
    }
    
    
}

#Preview {
  
    return MacroDetailedView(micro: DailyMicro(date: "\(Calendar.current.startOfDay(for: .now).formatted(date: .complete, time: .omitted))", carbs: 0, protein: 0, fats: 0)
    ).modelContainer(PreviewHelpers.mockModelContainer())
       
        
}
