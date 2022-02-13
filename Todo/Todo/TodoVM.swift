//
//  TodoVM.swift
//  Todo
//
//  Created by Yu on 2022/2/13.
//

import Foundation
import RealmSwift

class TodoVM: ObservableObject {
    // Realm instance
    private(set) var localRealm: Realm?
    // data instance
    @Published var todos = [Todo]()
    
    init(){
        startRealm()
        getTodos()
    }
    
    // start Realm
    func startRealm(){
        do {
            // default Realm configuration
            Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 1)
            // try to start Realm set to local var
            localRealm = try Realm()
        } catch {
            print("Error opening Realm", error)
        }
    }
    
    // get items
    func getTodos(){
        if let localRealm = localRealm {
            // get all todos from DB
            let allTodos = localRealm.objects(Todo.self).sorted(byKeyPath: "isDone")
            // clean up local-collection
            todos = []
            // list data to local-collection
            allTodos.forEach { dataTodo in
                todos.append(dataTodo)
            }
        }
    }
    
    
}
