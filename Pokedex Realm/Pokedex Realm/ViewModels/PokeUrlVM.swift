//
//  PokeUrlVM.swift
//  Pokedex Realm
//
//  Created by Yu on 2022/2/24.
//

import Foundation

class PokeUrlVM: ObservableObject {
    
    @Published var pokemons = [Pokemon]()
    
    var orderedPokemons:[Pokemon]  {
        return pokemons.sorted(by: {$0.id<$1.id})
    }
    
    
    init(){
        getPokeUrls { pokemonUrls in
            
            pokemonUrls.forEach { pokeUrl in
                self.getPokemon(url: pokeUrl.url) { apiPokemon in
                    self.pokemons.append(apiPokemon)
                }
            }
            
        }
    }
    
    func getPokeUrls(completed: @escaping (_ pokemonUrls: [PokemonUrl])->Void) {
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
    
    func getPokemon(url: String, completed: @escaping (_ apiPokemon: Pokemon)->Void) {
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
                        //                        self.pokemon = apiPoke
                        completed(apiPoke)
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
