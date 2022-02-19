//
//  ContentView.swift
//  Cat Realm
//
//  Created by Yu on 2022/2/19.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = CatVM()
    
    var body: some View {
        NavigationView{
            List(vm.breeds, id:\.id){ breed in
                NavigationLink{
                    DetailView(breed: breed)
                } label: {
                    ListRow(breed: breed)
                }
            }
            .navigationTitle("Cat")
            .refreshable {
                vm.checkUpdate()
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
