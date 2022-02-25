//
//  ContentView.swift
//  Pokedex Realm
//
//  Created by Yu on 2022/2/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = PokeVM()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(vm.orderedPokemons, id: \.id) { poke in
                    ListRow(pokemon: poke)
                }
            }
            .navigationTitle("PokeDex")
            .refreshable {
                vm.dataManager()
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
