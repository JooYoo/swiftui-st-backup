//
//  DetailView.swift
//  Pokedex
//
//  Created by Yu on 2022/2/26.
//

import SwiftUI

struct DetailView: View {
    let pokemon: Pokemon
    
    var body: some View {
        ScrollView{
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
            .frame(height: 300)
            
            Text(pokemon.name)
                .font(.title.bold())
            HStack(spacing: 10){
                Text("Height: \(pokemon.height)")
                Text("Weight: \(pokemon.weight)")
            }
            .padding(.top, 10)
        }
        .padding()
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
