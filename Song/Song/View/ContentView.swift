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
                    ForEach(vm.songs, id:\.self) { song in
                        Text(song.trackName)
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
