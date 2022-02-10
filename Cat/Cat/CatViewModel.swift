//
//  CatViewModel.swift
//  Cat
//
//  Created by Yu on 2022/2/10.
//

import Foundation
class CatVM: ObservableObject {
    
    @Published var breeds:[Breed] = []
    
    func fetchData() async {
        // 1. URL
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds?api_key=bda29416-bcb3-4cf4-9166-232459ed50d9") else {
            print("url error")
            return
        }
        
        // 2. fetch data
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let safeData = data {
                
                do {
                    // 3. decodw
                    let breeds = try JSONDecoder().decode([Breed].self, from: safeData)
                    print("🥰\(breeds.count)")
                } catch {
                    print("🤡 \(error)")
                }
            }
        }
        task.resume()
        
    }
}
