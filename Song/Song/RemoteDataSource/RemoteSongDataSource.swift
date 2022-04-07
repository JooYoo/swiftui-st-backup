//
//  RemoteSongDataSource.swift
//  Song
//
//  Created by Yu on 2022/4/7.
//

import Foundation

enum APIError: Error {
    case badUrl
    case badRequest
    case badResponse
    case badDecoding
}

class RemoteSongDataSource {
    
    
    func fetchSongs(_ artistName: String)async throws -> [Song]{
        
        guard let url = URL(string: "https://itunes.apple.com/search?term=jack+johnson") else{
            throw APIError.badUrl
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw APIError.badRequest
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.badResponse
        }
        
        
        guard let decoded = try? JSONDecoder().decode(Search.self, from: data) else{
            throw APIError.badDecoding
        }
        
        return decoded.results
    }
}
