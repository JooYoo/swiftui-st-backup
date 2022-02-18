//
//  PokeVM.swift
//  Pokedex
//
//  Created by Yu on 2022/2/16.
//

import Foundation

class PokeVM: ObservableObject {
    
    @Published var pokemons = [Pokemon]()
    
    
    init(){
        Task{
            await getPokeUrls()
        }
    }
    
    func getPokeUrls() async {
        // 0. clean up collection
        pokemons = []
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
                        for res in pokeUrlStore.results {
                            print(res.url)
                            Task {
                                await self.getPokemon(url: res.url)
                            }
                        }
                    }
                } catch {
                    print("🐞 getPokeUrls decoding failed:", error)
                }
            }
        }
        // 4. start task
        task.resume()
    }
    
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
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: safeData)
                    
                    DispatchQueue.main.async {
                        let newPokemon = Pokemon(id: pokemon.id, name: pokemon.name, height: pokemon.height, weight: pokemon.weight, sprites: pokemon.sprites)
                        self.pokemons.append(newPokemon)
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
