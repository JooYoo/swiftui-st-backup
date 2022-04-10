//
//  SongDetail.swift
//  Song
//
//  Created by Yu on 2022/4/10.
//

import SwiftUI

struct SongDetailView: View {
    var song:Song
    
    var body: some View {
        ScrollView{
            SongImg(urlStr: String.get300ArtWork(song.artworkUrl100)!, size: 300)
                .padding(.bottom, 10)
            
            Text(song.trackName)
                .font(.title.bold())
            Text(song.artistName)
                .font(.headline)
                .padding(.bottom, 5)
            
            Text(song.primaryGenreName)
                .font(.title2.italic())
            Divider()
            
            Text(song.collectionName ?? "nil")
                .font(.title3)
            Text("TODO: track preview")
            
        }
        .padding()
    }
}

struct SongDetail_Previews: PreviewProvider {
    static var previews: some View {
        let newSong = Song(artistName: "Nirvana", collectionName: "Nevermind", trackName: "Smells like teen spirit", previewUrl: "https://google.com", artworkUrl100: "https://is4-ssl.mzstatic.com/image/thumb/Music125/v4/db/d9/1a/dbd91afa-044d-637b-c557-847863c85a79/source/100x100bb.jpg", primaryGenreName: "Rock")
        
        SongDetailView(song: newSong)
    }
}
