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
                        AsyncImage(url: URL(string: (breed.image?.url)!)) { phase in
                            if let image = phase.image{
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }else if phase.error != nil{
                                Text("🐈")
                            }else{
                                ProgressView()
                            }
                        }
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
