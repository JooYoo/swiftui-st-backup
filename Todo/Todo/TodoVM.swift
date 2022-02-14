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
    @Published var inputVal = ""
    
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
            let allTodos = localRealm.objects(Todo.self) //.sorted(byKeyPath: "isDone")
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
                // change data in db
                try localRealm.write({
                    // create new Todo
                    let newTodo = Todo(value: ["txt": txt, "isDone": false])
                    // add to Realm
                    localRealm.add(newTodo)
                    // reload collection to display all items from DB
                    getTodos()
                    // clean up userInput
                    inputVal = ""
                })
            } catch {
                print("🐞 add Todo error:", error)
            }
        }
    }
    
    // MARK: - update item
    func updateTodo(id: ObjectId){
        if let localRealm = localRealm {
            do {
                // get the todo by id
                let theTodo = localRealm.objects(Todo.self).filter(NSPredicate(format: "id == %@", id))
                // change data in db
                try localRealm.write({
                    // update isDone of theTodo
                    theTodo[0].isDone.toggle()
                    // reload collection
                    getTodos()
                })
            } catch {
                print("🐞 update Todo error:", error)
            }
        }
    }
    
    // MARK: - delete item
    func deleteTodo(id: ObjectId){
        if let localRealm = localRealm {
            do {
                // get the todo by id
                let theTodo = localRealm.objects(Todo.self).filter(NSPredicate(format: "id == %@", id))
                
                guard !theTodo.isEmpty else { return }
                
                // change data in db
                try localRealm.write({
                    // delete
                    localRealm.delete(theTodo)
                    
                    // reload collection
                    getTodos()
                })
            } catch {
                print("🐞 delete Todo error:", error)
            }
        }
    }
    
    
    // MARK: - easy approach
    // retrive items
    // @ObservedResults(Todo.self, sortDescriptor: SortDescriptor.init(keyPath: "isDone", ascending: false)) var todosFetched
}
