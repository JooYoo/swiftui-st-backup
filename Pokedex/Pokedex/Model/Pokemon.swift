//
//  Pokemon.swift
//  Pokedex
//
//  Created by Yu on 2022/2/17.
//

import Foundation

struct Pokemon: Codable {
    var id: Int = 0
    var name: String = ""
    var height: Int = 0
    var weight: Int = 0
    var sprites: PokeSprites = PokeSprites()
}

struct PokeSprites: Codable {
    var front_default: String = ""
}
