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
                    NavigationLink{
                        DetailView(breed: breed)
                    } label: {
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
            .navigationTitle("Cat")
            .navigationViewStyle(.stack)
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
