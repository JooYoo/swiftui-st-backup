//
//  PokeUrlVM.swift
//  Pokedex Realm
//
//  Created by Yu on 2022/2/24.
//

import Foundation

class PokeUrlVM: ObservableObject {
    
    @Published var pokeUrls = [PokemonUrl]()
    
    
    init(){
        getPokeUrls { pokemonUrls in
            self.pokeUrls = pokemonUrls
        }
    }
    
    func getPokeUrls(  completed: @escaping (_ pokemonUrls: [PokemonUrl])->Void) {
        // 1. endpoint Url
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=151") else{
            return
        }
        
        // 2. fetch data
        let task = URLSession.shared.dataTask(with: url) { data, error, res in
            if let safeData = data{
                
                do {
                    // 3. decoder
                    let pokeUrlStore = try JSONDecoder().decode(PokeUrlStore.self, from: safeData)
                    
                    DispatchQueue.main.async {
                        completed(pokeUrlStore.results)
                    }
                } catch {
                    print("🐞 getPokeUrls decoding failed:", error)
                }
            }
        }
        // 4. start task
        task.resume()
    }
}
