//
//  Pokemon.swift
//  Pokedex Realm
//
//  Created by Yu on 2022/2/24.
//

import Foundation
import RealmSwift

class Pokemon: Object, Codable {
    @Persisted (primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var height: Int
    @Persisted var weight: Int
    @Persisted var sprites: PokeSprites?
}

class PokeSprites: Object, Codable {
    @Persisted var front_default: String
}
