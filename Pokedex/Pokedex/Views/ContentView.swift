//
//  ContentView.swift
//  Pokedex
//
//  Created by Yu on 2022/2/16.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = PokeUrlVM()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(vm.pokeUrls, id: \.id) { pokeUrl in
                    ListRow(url: pokeUrl.url)
                }
            }
            .navigationTitle("PokeDex")
        }
        .refreshable {
            Task{
                await vm.getPokeUrls()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
