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
                    HStack{
                        CatImageView(uwrappedUrlString: breed.image?.url ?? "nil")
                            .frame(width: 100, height: 100)
                        
                        VStack(alignment: .leading){
                            Text(breed.name)
                                .font(.title3.bold())
                            Text(breed.temperament)
                                .font(.caption)
                        }
                    }
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
