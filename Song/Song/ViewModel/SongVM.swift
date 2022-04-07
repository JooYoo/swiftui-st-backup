//
//  SongVM.swift
//  Song
//
//  Created by Yu on 2022/4/7.
//

import Foundation

class SongVM: ObservableObject {
    
    
    init(){
        
        Task {
            await getSongs()
        }
    }
    
    var repo = SongRepository()
    
    func getSongs() async {
        
        do {
            let songs = try await repo.getSongs("Jack Jonson")
            print(songs)
        } catch {
            print("🐞 fetch songs error")
        }
    }
    
    
    
    
}
