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
            VStack{
                TextField("input todo...", text: $vm.userInput)
                    .onSubmit {
                        vm.addTodo(txt: vm.userInput)
                    }
                Divider()
                List(vm.todosFetched, id: \.id){ todo in
                    Text(todo.txt)
                }
            }
            .navigationTitle("Todo")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
