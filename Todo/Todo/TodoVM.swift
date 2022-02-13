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
    @Published var userInput = ""
    
    init(){
        startRealm()
        getTodos()
    }
    
    // MARK: - start Realm
    func startRealm(){
        do {
            // default Realm configuration
            Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 1)
            // try to start Realm set to local var
            localRealm = try Realm()
        } catch {
            print("🐞 open Realm error:", error)
        }
    }
    
    // MARK: - retrieve items
    func getTodos(){
        if let localRealm = localRealm {
            // get all todos from DB
            let allTodos = localRealm.objects(Todo.self).sorted(byKeyPath: "isDone")
            // clean up local-collection
            todos = []
            // append data into local-collection
            allTodos.forEach { dataTodo in
                todos.append(dataTodo)
            }
        }
    }
    
    // MARK: - create item
    func addTodo(txt:String){
        if let localRealm = localRealm {
            do {
                try localRealm.write({
                    // create new Todo
                    let newTodo = Todo(value: ["txt": txt, "isDone": false])
                    // add to Realm
                    localRealm.add(newTodo)
                    // reload collection to display all items from DB
                    getTodos()
                    // clean up userInput
                    userInput = ""
                })
            } catch {
                print("🐞 add Todo error:", error)
            }
        }
    }
    
    
    
    
    
    // easy approach
    
    // retrive items from DB
    // @ObservedResults(Todo.self, sortDescriptor: SortDescriptor.init(keyPath: "isDone", ascending: false)) var todosFetched
}
