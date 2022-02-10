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
            List(vm.breeds, id:\.id){ breed in
                HStack{
                    // TODO: display image as avatar
                    Text(breed.id)
                    VStack(alignment: .leading){
                        Text(breed.name)
                        Text(breed.temperament)
                    }
                    
                }
                
            }
            .navigationTitle("Cat")
        }
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
