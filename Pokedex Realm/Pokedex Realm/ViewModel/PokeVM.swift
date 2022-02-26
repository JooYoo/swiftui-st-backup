//
//  PokeUrlVM.swift
//  Pokedex Realm
//
//  Created by Yu on 2022/2/24.
//

import Foundation
import RealmSwift

class PokeVM: ObservableObject {
    // realm
    private(set) var localRealm: Realm?
    
    // objs => UI
    @Published var pokemons = [Pokemon]()
    var orderedPokemons:[Pokemon]  {
        return pokemons.sorted(by: {$0.id<$1.id})
    }
    
    init(){
        startRealm()
        loadPokemons()
    }
    
    // MARK: - Networking
    func getPokeUrls(completed: @escaping (_ pokemonUrls: [PokemonUrl])->Void) {
        // 1. endpoint Url
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=151") else{
            print("🐞 getPokeUrls failed")
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
    
    func fetchApiData(){
        getPokeUrls { pokemonUrls in
            // pull to refresh
            self.pokemons = []
            // get pokemons via its url
            pokemonUrls.forEach { pokeUrl in
                self.getPokemon(url: pokeUrl.url) { apiPokemon in
                    // obj => DB
                    self.saveData(apiPokemon)
                    // obj => UI
                    self.pokemons.append(apiPokemon)
                }
            }
        }
    }
    
    // MARK: - Realm
    // open Realm
    func startRealm(){
        do {
            Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 1)
            localRealm = try Realm()
        } catch {
            print("🐞 open Realm failed:", error)
        }
    }
    
    // save Data
    func saveData(_ pokemon: Pokemon){
        // check Realm
        guard let localRealm = localRealm else {
            assertionFailure("🐞 use Realm failed when saveData")
            return
        }
        // obj => DB
        do {
            try localRealm.write({
                localRealm.add(pokemon, update: .modified)
            })
        } catch {
            print("🐞 save data failed:", error)
        }
    }
    
    // load Data
    func loadData(completed: @escaping (_ dbPokemons: Results<Pokemon>)->Void){
        // check Realm
        guard let localRealm = localRealm else {
            assertionFailure("🐞 use Realm failed when saveData")
            return
        }
        // DB => Results<Pokemon>
        let dbPokemons = localRealm.objects(Pokemon.self)
        
        completed(dbPokemons)
    }
    
    // MARK: - help funcs
    func loadPokemons(){
        loadData { dbPokemons in
            if dbPokemons.isEmpty {
                self.fetchApiData()
            }else{
                // Results<Pokemon> => objs
                dbPokemons.forEach({self.pokemons.append($0)})
            }
        }
    }
}
