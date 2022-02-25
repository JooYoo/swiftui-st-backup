//
//  ListRow.swift
//  Pokedex Realm
//
//  Created by Yu on 2022/2/24.
//

import SwiftUI
import Kingfisher

struct ListRow: View {
    let pokemon: Pokemon
    
    var body: some View {
        NavigationLink{
            DetailView(pokemon: pokemon)
        } label: {
            HStack{
                // list-row-Image
                KFImage(URL(string: pokemon.sprites!.front_default))
                    .placeholder({
                        Text("🐈")
                            .font(.system(size: 50))
                    })
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                
                // list-row-txt
                HStack{
                    Text("\(pokemon.id)")
                        .font(.system(size: 15))
                        .padding(5)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 1)
                        )
                    VStack(alignment: .leading){
                        Text(pokemon.name)
                            .font(.title2.bold())
                        Text("Weight: \(pokemon.weight)")
                            .font(.caption)
                    }
                }
            }
        }
        
    }
}

//struct ListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ListRow()
//    }
//}
