//
//  Search.swift
//  Song
//
//  Created by Yu on 2022/4/7.
//

import Foundation

struct Search: Codable {
    let results: [Song]
}

struct Song: Codable {
    var id = UUID()
    
    private enum CodingKeys:String, CodingKey {
        case artistName = "artistName"
        case collectionName = "collectionName"
        case trackName = "trackName"
        case previewUrl = "previewUrl"
        case artworkUrl100 = "artworkUrl100"
        case primaryGenreName = "primaryGenreName"
    }
    
    let artistName: String
    let collectionName: String?
    let trackName: String
    let previewUrl: String
    let artworkUrl100: String
    let primaryGenreName: String
}
