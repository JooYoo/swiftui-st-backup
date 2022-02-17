//
//  ListRow.swift
//  Pokedex
//
//  Created by Yu on 2022/2/17.
//

import SwiftUI

struct ListRow: View {
    @StateObject var vm = PokeVM()
    let url:String
    
    var body: some View {
        HStack{
            // Poke Image
            AsyncImage(url: URL(string: vm.pokeSpriteUrl)){ phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil{
                    Text("🐈")
                }else{
                    ProgressView()
                }
            }
            .frame(width: 100, height: 100)
            
            // Poke Txt
            HStack{
                Image(systemName: "\(vm.pokeId).circle")
                VStack(alignment: .leading){
                    
                    Text(vm.pokeName)
                        .font(.title2.bold())
                    Text("Weight: \(vm.pokeWeight)")
                        .font(.caption)
                }
            }
            
        }
        .task{
            await vm.getPokemon(url: url)
        }
    }
}

//struct ListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ListRow()
//    }
//}
