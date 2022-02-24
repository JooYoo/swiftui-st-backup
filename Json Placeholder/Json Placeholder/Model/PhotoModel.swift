//
//  PhotoModel.swift
//  Json Placeholder
//
//  Created by Yu on 2022/2/20.
//

import Foundation

struct Photo: Codable {
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
