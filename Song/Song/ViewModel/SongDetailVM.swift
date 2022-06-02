//
//  SongDetailVM.swift
//  Song
//
//  Created by Yu on 2022/6/2.
//

import Foundation
import AVFoundation

class SongDetailVM: ObservableObject{
    
    var player = AVPlayer()
    
    func playSound(_ audioUrl:String) {
        let playerItem = AVPlayerItem(url: URL(string: audioUrl)!)
        
        player = AVPlayer(playerItem: playerItem)
        player.play()
    }
    
    func stopSound(){
        player.pause()
    }
}
