//
//  PokeUrl.swift
//  Pokedex
//
//  Created by Yu on 2022/2/16.
//

import Foundation

struct PokeUrlStore: Codable {
    let results:[PokemonUrl]
}

struct PokemonUrl: Codable, Identifiable {
    let id = UUID()
    let url: String
}


