//
//  SongVM.swift
//  Song
//
//  Created by Yu on 2022/4/7.
//

import Foundation
import AVFoundation

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
    
    
    
    var player = AVPlayer()
    func playSound() {
        let playerItem = AVPlayerItem(url: URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/ce/48/5b/ce485b59-13b7-9859-0431-e602d6347479/mzaf_7168871676263777717.plus.aac.p.m4a")!)
        
        player = AVPlayer(playerItem: playerItem)
        player.play()
        
        print("working")
    }
    
}
