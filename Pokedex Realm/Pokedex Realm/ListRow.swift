//
//  ListRow.swift
//  Pokedex Realm
//
//  Created by Yu on 2022/2/24.
//

import SwiftUI

struct ListRow: View {
    let url: String
    
    @StateObject private var vm = PokeVM()
    
    var body: some View {
        NavigationLink{
            Text(vm.pokemon.name)
        } label: {
            HStack{
                // list-row-Image
                AsyncImage(url: URL(string: vm.pokemon.sprites.front_default)){ phase in
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
                
                // list-row-txt
                HStack{
                    Text("\(vm.pokemon.id)")
                        .font(.system(size: 15))
                        .padding(5)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 1)
                        )
                    VStack(alignment: .leading){
                        Text(vm.pokemon.name)
                            .font(.title2.bold())
                        Text("Weight: \(vm.pokemon.weight)")
                            .font(.caption)
                    }
                }
            }
        }
        .onAppear{
            Task{
                await vm.getPokemon(url: url)
            }
        }
    }
    
}

//struct ListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ListRow()
//    }
//}
