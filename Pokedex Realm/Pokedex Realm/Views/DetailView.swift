//
//  DetailView.swift
//  Pokedex Realm
//
//  Created by Yu on 2022/2/25.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    let pokemon: Pokemon
    
    var body: some View {
        ScrollView{
            KFImage(URL(string: pokemon.sprites!.front_default))
                .placeholder({
                    Text("🐈")
                        .font(.system(size: 50))
                })
                .resizable()
                .scaledToFit()
                .frame(width: .infinity, height: 300)
            
            Text(pokemon.name)
                .font(.title.bold())
            
            HStack(spacing: 10){
                Text("Height: \(pokemon.height)")
                Text("Wight: \(pokemon.weight)")
            }
            .foregroundColor(.gray)
            .padding(.top, 10)
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
