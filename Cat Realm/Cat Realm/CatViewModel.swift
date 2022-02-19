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
                        // API Data => UI
                        self.breeds = breeds
                        
                        // API Data => DB
                        breeds.forEach { breed in
                            self.saveBreed(breed)
                        }
                    }
                } catch {
                    print("decode error: \(error)")
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Persistent Data
    // init Realm in local
    func startRealm(){
        do {
            Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 1)
            localRealm = try Realm()
        } catch {
            print("🐞 open Realm error:", error)
        }
    }
    
    // retrieve items
    func getBreeds(){
        if let localRealm = localRealm {
            // get all breeds from DB
            let allBreeds = localRealm.objects(Breed.self)
            
            print("⏱:", allBreeds.count)
            
            // empty DB => fetch from API
            if allBreeds.isEmpty{
                Task {
                    await fetchData()
                }
            } else{
                // append data into local-collection
                allBreeds.forEach { dataBreed in
                    breeds.append(dataBreed)
                }
            }
        }
    }
    
    // save item
    func saveBreed(_ breed: Breed){
        if let localRealm = localRealm {
            do {
                // change data in db
                try localRealm.write({
                    // check if exist
                    let existBreed = localRealm.objects(Breed.self).filter(NSPredicate(format: "id == %@", breed.id))
                    
                    if existBreed.isEmpty {
                        // add to Realm
                        localRealm.add(breed)
                    }
                })
            } catch {
                print("🐞 add Todo error:", error)
            }
        }
    }
    
}
