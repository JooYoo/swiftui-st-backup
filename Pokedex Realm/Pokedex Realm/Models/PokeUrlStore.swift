//
//  PokeUrlStore.swift
//  Pokedex Realm
//
//  Created by Yu on 2022/2/24.
//

import Foundation

struct PokeUrlStore: Codable {
    let results:[PokemonUrl]
}

struct PokemonUrl: Codable, Identifiable {
    let id = UUID()
    let url: String
}
