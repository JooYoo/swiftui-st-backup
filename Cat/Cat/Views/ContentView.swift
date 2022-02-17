//
//  ContentView.swift
//  Cat
//
//  Created by Yu on 2022/2/9.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = CatVM()
    
    var body: some View {
        NavigationView{
            List(vm.results, id:\.id){ breed in
                NavigationLink{
                    DetailView(breed: breed)
                } label: {
                    ListRow(breed: breed)
                }
            }
            .searchable(text: $vm.searchingFor)
            .navigationTitle("Cat")
        }
        .navigationViewStyle(.stack)
        .task {
            await vm.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
