//
//  MacroView.swift
//  Health
//
//  Created by Saransh Singhal on 18/06/24.
//

import SwiftUI
import SwiftData


struct MacroView: View {
    @State var isPopup : Bool = false
    @Environment(\.modelContext) var modelContext
    @State var isPresent : Bool = false
    @StateObject var dataFetcher : NutritionAPi
    @State var carbs: Int = 0 {
         didSet { updateCalories() }
     }
     @State var protein: Int = 0 {
         didSet { updateCalories() }
     }
     @State var fats: Int = 0 {
         didSet { updateCalories() }
     }
     @State var calories: Int = 0
    
    @State var caloriesMax : Int = 0
    @State var carbMax = 0
    @State var proMax = 0
    @State var fatbMax = 0
    
    
   
    @Query(sort : \Micro.date, order: .reverse) var micros : [Micro]
    @State var dailyMicro = [DailyMicro]()
    var body: some View {
      
        NavigationStack {
            VStack(content: {
                
                HStack{
                    Text("Today's Micros")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        
                    Spacer()
                }
                MicroHeaderView(carbs: $carbs, fats: $fats, protein: $protein, calories: $calories, caloriMax: $caloriesMax, proMax: $proMax, carbMax: $carbMax, fatsMax: $fatbMax)
                
                HStack{
                    Circle()
                        .foregroundStyle(.cyan)
                        .frame(width: 15)
                    
                    Text("Calories")
                    
                    Spacer()
                    
                    Circle()
                        .foregroundStyle(.green)
                        .frame(width: 15)
                    
                    Text("Carbs")
                    
                    Spacer()
                    
                    Circle()
                        .foregroundStyle(.blue)
                        .frame(width: 15)
                    
                    Text("Fats")
                    
                    Spacer()
                    
                    Circle()
                        .foregroundStyle(.red)
                        .frame(width: 15)
                    
                    Text("Protein")
                    
                    
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).fill(.gray.opacity(0.2)).shadow(radius: 10))
               
                
                HStack{
                    Text("Previous Micros")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                }.padding(.vertical)
                
                
                   
                        
                            
                            ScrollView{
                                ForEach(dailyMicro){ micros in
                                   
                                        NavigationLink {
                                            MacroDetailedView(micro: micros)
                                        } label: {
                                            MicroDayView(micro: micros)
                                        }
         
                                }
                            }
                            
                        
                    
                
            })
            
            .popover(isPresented: $isPopup, attachmentAnchor: .point(.center), arrowEdge: .top, content: {
                CalorieTarget()
                
            }).padding()
            .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.orange.opacity(0.8), Color.white]),
                                startPoint: .top,
                                endPoint: .bottom
                            ))
            
            
            
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .toolbar(content: {
                
                ToolbarItem {
                    Button{
                        isPopup.toggle()
                    }
                label:{
                    Image(systemName: "pencil")
                }
                }
                
                ToolbarItem {
                    
                    
                    
                    Button{
                        isPresent.toggle()
                    }
                label:{
                    Image(systemName: "plus")
                }
                }
            })
            .sheet(isPresented: $isPresent,onDismiss: {
                fetchDailyMicros()
                fetchTodaysMicros()
                MicroHeaderView(carbs: $carbs, fats: $fats, protein: $protein, calories: $calories, caloriMax: $caloriesMax, proMax: $proMax, carbMax: $carbMax, fatsMax: $fatbMax).Calories()
            }, content: {
                AddMealView(addMeal: { food, date in
                    print("This food items is :: \(food)")
                    Task
                    {
                        
                        if let result : MicrosData = await dataFetcher.fetchData(query: "\(food)"){
                            
                            
                            DispatchQueue.main.async{
                                
                                saveMicros(result: result, date: date)
                            }
                        }else{
                            print("Error")
                        }
                    }
                })
                .presentationDetents([.fraction(0.4)])
            })
            .onAppear(){
                fetchDailyMicros()
                fetchTodaysMicros()
                printAllData()
                getCalories()
                MicroHeaderView(carbs: $carbs, fats: $fats, protein: $protein, calories: $calories, caloriMax: $caloriesMax, proMax: $proMax, carbMax: $carbMax, fatsMax: $fatbMax).Calories()
                
            }
            
        }
        
    }
    
    private func updateCalories() {
          calories = (carbs * 4) + (fats * 9) + (protein * 4)
      }
    
    private func getCalories(){
        updateCalories()
        let descriptor = FetchDescriptor<UserCalories>()
            do{
                let data = try modelContext.fetch(descriptor)
                let reversedData = data.reversed()
                caloriesMax = reversedData.first?.calories ?? 0
                carbMax = reversedData.first?.carbs ?? 0
                proMax = reversedData.first?.protein ?? 0
                fatbMax = reversedData.first?.fats ?? 0
                
               print(caloriesMax)
                
             }
            catch{
                print(error.localizedDescription)
            }
    }
    
    private func fetchTodaysMicros(){
        updateCalories()
        if let firstData = dailyMicro.first, firstData.date == "\(Calendar.current.startOfDay(for: .now).formatted(date: .complete, time: .omitted))"{
            carbs = firstData.carbs
            fats = firstData.fats
            protein = firstData.protein
        }
    }
    
    private func fetchDailyMicros(){
        let dates : Set<String> = Set(micros.map({$0.date}))
        
        
        var dailyMicros = [DailyMicro]()
        
        for date in dates{
            let filterMicroData = micros.filter({$0.date == date})
            
            let carbs : Int = filterMicroData.reduce(0, {$0 + $1.carbs})
            let protein : Int = filterMicroData.reduce(0, {$0 + $1.protein})
            let fats : Int = filterMicroData.reduce(0, {$0 + $1.fats})
            
            let micro = DailyMicro(date: date, carbs: carbs, protein: protein, fats: fats)
            
            dailyMicros.append(micro)
        }
        self.dailyMicro = dailyMicros
    }
    
   
   
    
    private func saveMicros(result : MicrosData, date : Date){
        updateCalories()
        let item = result.items
        let macro = Micro(food: item.first!.name, createdAt: date, date: "\(date.formatted(date: .complete, time: .omitted))", carbs: Int(item.first!.carbohydratesTotalG), protein: Int(item.first!.proteinG), fats: Int(item.first!.fatTotalG), calories: item.first!.calories, servingSizeG: item.first!.servingSizeG, saturatedFat: item.first!.fatSaturatedG, sodiumMg: item.first!.sodiumMg, potassiumMg: item.first!.potassiumMg, cholesterolMg: item.first!.cholesterolMg, fiberG: item.first!.fiberG, sugarG: item.first!.sugarG)
        
        modelContext.insert(macro)
        
        print(micros)
       
    }
    
    func printAllData(){
        let descriptor = FetchDescriptor<Micro>()
                
                do {
                    let fetchedData = try modelContext.fetch(descriptor)
                    DispatchQueue.main.async {
                       
                        // Print all fetched data
                        fetchedData.forEach { Micro in
                            print(Micro.date)
                            print(Micro.carbs)
                            print(Micro.createdAt)
                        }
                    }
                } catch {
                    print("Error fetching data: \(error.localizedDescription)")
                }
    }
}

#Preview {
    
    
    return MacroView(dataFetcher: NutritionAPi())
        .modelContainer(PreviewHelpers.mockModelContainer())
}
