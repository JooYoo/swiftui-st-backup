//
//  CatModel.swift
//  Cat Realm
//
//  Created by Yu on 2022/2/19.
//

import Foundation
import RealmSwift

class Breed: Object, Codable  {
    @Persisted var id: String // FIXME: what if the API-JSON has no id
    @Persisted var name: String
    @Persisted var temperament: String
    @Persisted var origin: String
//  @Persisted var description: String // FIXME: why 'description' can't be used
    @Persisted var image: CatImg?
}

class CatImg: Object, Codable {
    @Persisted var url: String?
}
