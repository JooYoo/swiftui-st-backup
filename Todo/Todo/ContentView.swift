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
                    InputBox(inputValue: $vm.inputVal)
                }
                Section{
                    ForEach(vm.todos, id: \.id){ todo in
                        if !todo.isInvalidated {
                            ListItem(todo: todo)
                                .onTapGesture(count: 1) {
                                    vm.updateTodo(id: todo.id)
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive){
                                        vm.deleteTodo(id: todo.id)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
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
