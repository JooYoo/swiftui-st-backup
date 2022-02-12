//
//  CatViewModel.swift
//  Cat
//
//  Created by Yu on 2022/2/10.
//

import Foundation
class CatVM: ObservableObject {
    // model
    @Published var breeds:[Breed] = []
    // search-filter
    @Published var searchingFor = ""
    
    // search-filter
    var results:[Breed] {
        if searchingFor.isEmpty {
            return breeds
        } else {
            return breeds.filter{ $0.name.contains(searchingFor) }
        }
    }
    
    // networing
    func fetchData() async {
        // 1. URL
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds") else {
            print("url error")
            return
        }
        
        // 2. fetch data
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let safeData = data {
                
                do {
                    // 3. decode
                    let breeds = try JSONDecoder().decode([Breed].self, from: safeData)
                    
                    DispatchQueue.main.async {
                        self.breeds = breeds
                    }
                } catch {
                    print("decode error: \(error)")
                }
            }
        }
        task.resume()
    }
}
