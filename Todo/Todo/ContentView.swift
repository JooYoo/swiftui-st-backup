//
//  ContentView.swift
//  Todo
//
//  Created by Yu on 2022/2/13.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = TodoVM()
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("input todo...", text: $vm.inputVal)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                Section{
                    
                    ForEach(vm.todos, id: \.id){ todo in
                        Text(todo.txt)
                            .strikethrough(todo.isDone)
                            .padding(.vertical, 15)
                            .onTapGesture(count: 1) {
                                // TODO: add db function
                                vm.updateTodo(id: todo.id)
                            }
                    }
                }
            }
            .onSubmit {
                vm.addTodo(txt: vm.inputVal)
            }
            .navigationTitle("Todo")
            
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
