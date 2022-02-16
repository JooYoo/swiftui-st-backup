//
//  PokeUrl.swift
//  Pokedex
//
//  Created by Yu on 2022/2/16.
//

import Foundation

struct PokeUrlRepo: Codable {
    let results:[PokemonUrl]
}

struct PokemonUrl: Codable {
    let url: String
}


