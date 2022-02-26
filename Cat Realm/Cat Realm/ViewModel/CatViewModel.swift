//
//  CatViewModel.swift
//  Cat Realm
//
//  Created by Yu on 2022/2/19.
//

import Foundation
import RealmSwift

class CatVM: ObservableObject {
    // model
    @Published var breeds:[Breed] = []
    
    // realm
    private(set) var localRealm: Realm?
    
    init(){
        startRealm()
        getBreeds()
    }
    
    // MARK: - Networking
    func fetchData(completion: @escaping (_ apiBreeds: [Breed])->Void) {
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
                        completion(breeds)
                    }
                } catch {
                    print("decode error: \(error)")
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Realm
    func startRealm(){
        do {
            Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 1)
            localRealm = try Realm()
        } catch {
            print("🐞 open Realm error:", error)
        }
    }
    
    func loadData(completed: @escaping (_ dbCats:Results<Breed>)->Void){
        guard let localRealm = localRealm else {
            return
        }
        
        let dbCats = localRealm.objects(Breed.self)
        
        completed(dbCats)
    }
    
    // save item
    func saveData(_ breed: Breed){
        guard let localRealm = localRealm else {
            assertionFailure("Databaase is not initialized")
            return
        }
        
        do {
            // change data in db
            // TODO: save objs is possible
            try localRealm.write({
                localRealm.add(breed, update: .modified)
            })
        } catch {
            print("🐞 add Todo error:", error)
        }
    }
    
    // MARK: - help funcs
    // retrieve items: either from DB or API
    func getBreeds(){
        loadData { dbCats in
            if dbCats.isEmpty {
                self.fetchData(completion: { apiBreeds in
                    // API data => DB
                    apiBreeds.forEach { self.saveData($0) }
                    // API data => UI
                    self.breeds = apiBreeds
                })
            }else{
                dbCats.forEach({self.breeds.append($0)})
            }
        }
    }
}
