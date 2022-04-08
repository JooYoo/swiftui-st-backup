//
//  SongRepository.swift
//  Song
//
//  Created by Yu on 2022/4/7.
//

import Foundation

class SongRepository {
    
    let remoteDS = RemoteSongDataSource()
    
    func getSongs(_ artistName: String) async throws -> [Song] {
        let _songs = try await remoteDS.fetchSongs(artistName)
        return _songs
    }
}
