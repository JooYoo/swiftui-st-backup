//
//  Pokemon.swift
//  Pokedex
//
//  Created by Yu on 2022/2/17.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: PokeSprites
}

struct PokeSprites: Codable {
    let front_default: String
}
