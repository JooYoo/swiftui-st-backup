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
                    TextField("input todo...", text: $vm.userInput)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                Section{
                    ForEach(vm.todos, id: \.id){ todo in
                        Text(todo.txt)
                            .strikethrough(false)
                            .padding(.vertical, 15)
                        
                    }
                }
            }
            .onSubmit {
                vm.addTodo(txt: vm.userInput)
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
