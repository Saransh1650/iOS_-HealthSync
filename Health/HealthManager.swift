//
//  HealthManager.swift
//  Health
//
//  Created by Saransh Singhal on 13/06/24.
//

import SwiftUI
import HealthKit

extension Date{
    static var startofDate : Date{
        Calendar.current.startOfDay(for: Date())
    }
    static var oneMonthAgo: Date {
        let calendar = Calendar.current
        let oneMonth = calendar.date(byAdding: .month, value: -1,to: Date())
        return calendar.startOfDay(for: oneMonth!)
    }
    
    static var startOfWeek: Date? {
        let calendar = Calendar.current
        var
        components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from : Date())
        components.weekday = 2
        return calendar.date(from: components)
    }
}

class HealthManager : ObservableObject{
    @Published var activity : [String : Activity] = [:]
    @Published var oneMonthStepData = [DailyStepView]()
    @Published var mockActivities : [String: Activity] =
    ["todays Steps" : Activity(id: 0, title: "Steps", subTitle: "Goal : 10000", tint: .blue, amount: "1234", image: "figure.walk"),
     "calories burned" : Activity(id: 1, title: "Calories", subTitle: "Goal : 10000", tint: .cyan, amount: "123", image: "flame.fill")

    ]
    let healthStore = HKHealthStore()
    init(){
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)
        let workoutType = HKQuantityType.workoutType()
        let healthType : Set = [steps, calories, workoutType]
        
        Task {
            do{
                try await healthStore.requestAuthorization(toShare: [], read: healthType)
                fetchTodaysData()
                fetchTodaysCalories()
                fetchWeekRunning()
                fetchWeightLiftingStats()
                fetchSoccerStats()
                fetchBasketBallStats()
                fetchStairsStats()
                fetchSwimmingStats()
                fetchStepsData()
            } catch {
                print("Error in fetching health data")
            }
        }
    }
    
    func fetchDailySteps(startDate: Date, completion: @escaping ([DailyStepView]) -> Void) {
        let steps = HKQuantityType(.stepCount)
        let interval = DateComponents (day: 1)
        let query = HKStatisticsCollectionQuery(quantityType: steps, quantitySamplePredicate: nil, anchorDate: startDate,
        intervalComponents: interval)
        query.initialResultsHandler = { query, result, error in
            guard let result = result else{
                completion([])
                return
            }
            var dailySteps = [DailyStepView]()
            result.enumerateStatistics(from: startDate, to: Date()) { statistics, stop in
                dailySteps.append(DailyStepView(date: statistics.startDate, stepCount: statistics.sumQuantity()?.doubleValue(for: .count()) ?? 0.00))
            }
            completion(dailySteps)
        }
        healthStore.execute(query)
    }
    func fetchTodaysData() {
        let steps = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let now = Date()
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            if let error = error {
                            print("Error fetching today's data: \(error.localizedDescription)")
                            return
                        }
                        
                        guard let quantity = result?.sumQuantity() else {
                            print("No step count data available for today.")
                            return
                        }
            let stepCount = quantity.doubleValue(for: .count())
            print(stepCount.formattedString())
            
            let activity = Activity(id: 0, title: "Steps", subTitle: "Goal : 10000", tint: .blue, amount: stepCount.formattedString(), image: "figure.walk")
            
            DispatchQueue.main.async{
                self.activity["Todays Steps"] = activity
            }
            
            
        }
        
        healthStore.execute(query)
    }
    
    
    func fetchTodaysCalories() {
        let steps = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let now = Date()
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            if let error = error {
                            print("Error fetching today's data: \(error.localizedDescription)")
                            return
                        }
                        
                        guard let quantity = result?.sumQuantity() else {
                            print("No step count data available for today.")
                            return
                        }
            let caloriesBurned = quantity.doubleValue(for: .kilocalorie())
            print(caloriesBurned.formattedString())
            
            let activity = Activity(id: 1, title: "Calories", subTitle: "Goal : 10000", tint: .orange, amount: caloriesBurned.formattedString(), image: "flame.fill")
            
            DispatchQueue.main.async{
                self.activity["Today's Calories"] = activity
            }
            
            
        }
        
        healthStore.execute(query)
    }
    
    func fetchWeekRunning(){
        let workout = HKSampleType.workoutType()
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .running)
        let timePredicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, workoutPredicate])
        
        let query = HKSampleQuery (sampleType: workout, predicate: predicate, limit: 10,sortDescriptors: nil){ _, sample, error in
            guard let workouts = sample as? [HKWorkout], error == nil else {
                print("error fetching week running data")
                return
            }
            var count = 0
            for workout in workouts {
                let duration = Int (workout.duration)/60
                count += duration
            }
            print(count)
            let activity = Activity(id: 2, title: "Running", subTitle: "This Week", tint: .purple, amount: "\(count) minutes", image: "figure.run")
            
            DispatchQueue.main.async {
                self.activity["Running"] = activity
            }
        }
        healthStore.execute(query)
    }
    
    func fetchWeightLiftingStats(){
        let workout = HKSampleType.workoutType()
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .traditionalStrengthTraining)
        let timePredicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, workoutPredicate])
        
        let query = HKSampleQuery (sampleType: workout, predicate: predicate, limit: 20,sortDescriptors: nil){ _, sample, error in
            guard let workouts = sample as? [HKWorkout], error == nil else {
                print("error fetching week running data")
                return
            }
            var count = 0
            for workout in workouts {
                
                let duration = Int (workout.duration)/60
                count += duration
            }
            print(count)
            let activity = Activity(id: 3, title: "Weight Lift", subTitle: "This Week", tint: .gray, amount: "\(count) minutes", image: "dumbbell.fill")
            
            DispatchQueue.main.async {
                self.activity["Weight Lifting"] = activity
            }
        }
        healthStore.execute(query)
    }
    
    func fetchSoccerStats(){
        let workout = HKSampleType.workoutType()
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .soccer)
        let timePredicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, workoutPredicate])
        
        let query = HKSampleQuery (sampleType: workout, predicate: predicate, limit: HKObjectQueryNoLimit,sortDescriptors: nil){ _, sample, error in
            guard let workouts = sample as? [HKWorkout], error == nil else {
                print("error fetching week running data")
                return
            }
            var count = 0
            for workout in workouts {
                
                let duration = Int (workout.duration)/60
                count += duration
            }
            print(count)
            let activity = Activity(id: 4, title: "Soccer", subTitle: "This Week", tint: .white, amount: "\(count) minutes", image: "figure.soccer")
            
            DispatchQueue.main.async {
                self.activity["Soccer"] = activity
            }
        }
        healthStore.execute(query)
    }
    
    func fetchBasketBallStats(){
        let workout = HKSampleType.workoutType()
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .basketball)
        let timePredicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, workoutPredicate])
        
        let query = HKSampleQuery (sampleType: workout, predicate: predicate, limit: 20,sortDescriptors: nil){ _, sample, error in
            guard let workouts = sample as? [HKWorkout], error == nil else {
                print("error fetching week running data")
                return
            }
            var count = 0
            for workout in workouts {
                
                let duration = Int (workout.duration)/60
                count += duration
            }
            print(count)
            let activity = Activity(id: 5, title: "BasketBall", subTitle: "This Week", tint: .orange, amount: "\(count) minutes", image: "figure.basketball")
            
            DispatchQueue.main.async {
                self.activity["BasketBall"] = activity
            }
        }
        healthStore.execute(query)
    }
    
    func fetchStairsStats(){
        let workout = HKSampleType.workoutType()
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .stairClimbing)
        let timePredicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, workoutPredicate])
        
        let query = HKSampleQuery (sampleType: workout, predicate: predicate, limit: HKObjectQueryNoLimit,sortDescriptors: nil){ _, sample, error in
            guard let workouts = sample as? [HKWorkout], error == nil else {
                print("error fetching week running data")
                return
            }
            var count = 0
            for workout in workouts {
                
                let duration = Int (workout.duration)/60
                count += duration
            }
            print(count)
            let activity = Activity(id: 6, title: "Stairs", subTitle: "This Week", tint: .cyan, amount: "\(count) minutes", image: "figure.stair.stepper")
            
            DispatchQueue.main.async {
                self.activity["Stairs Climbing"] = activity
            }
        }
        healthStore.execute(query)
    }
    
    func fetchSwimmingStats(){
        let workout = HKSampleType.workoutType()
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .swimming)
        let timePredicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, workoutPredicate])
        
        let query = HKSampleQuery (sampleType: workout, predicate: predicate, limit: 20,sortDescriptors: nil){ _, sample, error in
            guard let workouts = sample as? [HKWorkout], error == nil else {
                print("error fetching week running data")
                return
            }
            var count = 0
            for workout in workouts {
                
                let duration = Int (workout.duration)/60
                count += duration
            }
            print(count)
            let activity = Activity(id: 7, title: "Swimming", subTitle: "This Week", tint: .blue, amount: "\(count) minutes", image: "figure.pool.swim")
            
            DispatchQueue.main.async {
                self.activity["Swimming"] = activity
            }
        }
        healthStore.execute(query)
    }
 }

extension Double {
        func formattedString() -> String {
            let numberFormatter = NumberFormatter ()
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 0
            return numberFormatter.string(from: NSNumber(value: self))!
    }
}


extension HealthManager{
    func fetchStepsData(){
        fetchDailySteps(startDate: .oneMonthAgo) { dailySteps in
            DispatchQueue.main.async{
                self.oneMonthStepData = dailySteps
            }
        }
    }
}
