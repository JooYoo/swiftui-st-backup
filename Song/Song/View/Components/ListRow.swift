//
//  ListRow.swift
//  Song
//
//  Created by Yu on 2022/4/10.
//

import SwiftUI

struct ListRow: View {
    var song: Song
    
    var body: some View {
        NavigationLink{
            SongDetail(song: song)
        } label: {
            HStack{
                SongImg(urlStr: song.artworkUrl100, size: 60)
                
                VStack(alignment: .leading) {
                    Text(song.trackName)
                        .font(.title3.bold())
                    Text(song.artistName)
                }
            }
        }
    }
}

//struct ListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ListRow()
//    }
//}
