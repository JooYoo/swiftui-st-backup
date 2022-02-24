//
//  ListRow.swift
//  Pokedex Realm
//
//  Created by Yu on 2022/2/24.
//

import SwiftUI

struct ListRow: View {
    let pokemon: Pokemon
    
    var body: some View {
        NavigationLink{
            Text(pokemon.name)
        } label: {
            HStack{
                // list-row-Image
                AsyncImage(url: URL(string: pokemon.sprites.front_default)){ phase in
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
