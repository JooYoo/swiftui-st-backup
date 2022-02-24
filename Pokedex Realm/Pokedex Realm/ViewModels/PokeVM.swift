//
//  PokeVM.swift
//  Pokedex Realm
//
//  Created by Yu on 2022/2/24.
//

import Foundation

class PokeVM: ObservableObject {
    @Published var pokemon = Pokemon()
    
    func getPokemon(url: String) async {
        // 1. URL
        guard let url = URL(string: url) else {
            return
        }
        
        // 2. task
        let task = URLSession.shared.dataTask(with: url) { data, error, res in
            
            if let safeData = data {
                
                // 3. decode
                do {
                    let apiPoke = try JSONDecoder().decode(Pokemon.self, from: safeData)
                    
                    DispatchQueue.main.async {
                        self.pokemon = apiPoke
                    }
                } catch {
                    print("🐞 getPokemon decoding failed:", error)
                }
            }
        }
        
        // 4. run task
        task.resume()
    }
}
