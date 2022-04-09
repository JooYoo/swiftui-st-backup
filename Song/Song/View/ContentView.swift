//
//  ContentView.swift
//  Song
//
//  Created by Yu on 2022/3/27.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = SongVM()
    
    
    var body: some View {
        NavigationView {
            List{
                
                Section{
                    TextField("artist name", text: $vm.inputVal)
                }
                
                Section {
                    ForEach(vm.songs, id:\.id) { song in
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
            .navigationTitle("Songs")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
