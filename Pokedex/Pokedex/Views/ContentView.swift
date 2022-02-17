//
//  ContentView.swift
//  Pokedex
//
//  Created by Yu on 2022/2/16.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = PokeVM()
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    ForEach(vm.pokemons, id: \.id) { pokemon in
                        
                        NavigationLink{
                            Text(pokemon.name)
                        } label: {
                            ListRow(pokemon: pokemon)
                        }
                    }
                }
            }
            .navigationTitle("PokeDex")
        }
        .task {
          await vm.getPokeUrls()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
