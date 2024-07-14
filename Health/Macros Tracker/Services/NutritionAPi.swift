//
//  NutritionAPi.swift
//  Health
//
//  Created by Saransh Singhal on 22/06/24.
//

import Foundation

class NutritionAPi : ObservableObject {
    func fetchData(query : String)async -> MicrosData? {
        
        let query = "\(query)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.calorieninjas.com/v1/nutrition?query="+query!)!
        var request = URLRequest(url: url)
        request.setValue("\(SecretKey.key)", forHTTPHeaderField: "X-Api-Key")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let result = try JSONDecoder().decode(MicrosData.self, from: data)
                return result
            } else {
                print("Server error: \(response)")
                return nil
            }
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
            return nil
        }
        
    
    
       
    }
}
