//
//  PokeVM.swift
//  Pokedex
//
//  Created by Yu on 2022/2/16.
//

import Foundation

class PokeVM: ObservableObject {
    
    @Published var pokeUrls = [PokemonUrl]()
    
    func getPokeUrls() async {
        // 1. endpoint Url
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=151") else{
            return
        }
        
        // 2. fetch data
        let task = URLSession.shared.dataTask(with: url) { data, error, res in
            if let safeData = data{
                
                do {
                    // 3. decoder
                    let pokeUrlRepo = try JSONDecoder().decode(PokeUrlRepo.self, from: safeData)
                    
                    DispatchQueue.main.async {
                        self.pokeUrls = pokeUrlRepo.results
                    }
                } catch {
                    print("🐞 decoding failed:", error)
                }
            }
        }
        // 4. start task
        task.resume()
    }
}
