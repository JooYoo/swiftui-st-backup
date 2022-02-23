//
//  CatModel.swift
//  Cat Realm
//
//  Created by Yu on 2022/2/19.
//

import Foundation
import RealmSwift

class Breed: Object, Codable  {
    @Persisted var id : String
    @Persisted var name: String
    @Persisted var temperament: String
    @Persisted var origin: String
    @Persisted var additonialInfo: String
    @Persisted var image: CatImg?
    
    override static func primaryKey() -> String? {
        "id"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case temperament
        case origin
        case additonialInfo = "description"
        case image
        
    }
}

class CatImg: Object, Codable {
    @Persisted var url: String?
}
