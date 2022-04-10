//
//  StringExt.swift
//  Song
//
//  Created by Yu on 2022/4/10.
//

import Foundation

extension String {
    // .../100x100bb.jpg => .../300x300bb.jpg
    static func get300ArtWork(_ artworkUrl100:String)->String?{
        let removed100Ending = artworkUrl100.dropLast(13)
        return removed100Ending + "300x300bb.jpg"
    }
}
