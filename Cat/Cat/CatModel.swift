//
//  CatModel.swift
//  Cat
//
//  Created by Yu on 2022/2/10.
//

import Foundation

struct Breed: Codable {
    let id: String
    let name: String
    let temperament: String
    let origin: String
    let description: String
    let image: CatImg?
}

struct CatImg: Codable {
    let url: String?
}
