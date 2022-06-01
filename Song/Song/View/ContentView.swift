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
                Section {
                    Button {
                        vm.playSound()
                    } label: {
                        Text("press me")
                    }
                }
                Section{
                    TextField("artist name", text: $vm.inputVal)
                }
                
                Section {
                    ForEach(vm.songs, id:\.id) { song in
                        ListRow(song: song)
                    }
                } 
            }
            .navigationTitle("Songs")
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
