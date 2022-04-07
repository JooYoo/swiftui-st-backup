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
    let artistName: String
    let collectionName: String?
    let trackName: String
    let previewUrl: String
    let artworkUrl100: String
    let primaryGenreName: String
}
