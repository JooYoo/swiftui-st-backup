//
//  SongVM.swift
//  Song
//
//  Created by Yu on 2022/4/7.
//

import Foundation

class SongVM: ObservableObject {
    // app-data
    var repo = SongRepository()
    // ui-data
    @Published var songs = [Song]()
    @Published var inputVal = ""
    
    init(){
        getSongs()
    }
    
    func getSongs() {
        
        Task{
            do {
                // TODO: how to input artistName as param
                songs = try await repo.getSongs("jack jonson")
                print(songs)
            } catch {
                print("🐞 fetch songs error")
            }
        }
        
    }
    
    
    
    
}
