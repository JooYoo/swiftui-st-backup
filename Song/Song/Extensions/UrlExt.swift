//
//  UrlExt.swift
//  Song
//
//  Created by Yu on 2022/4/8.
//

import Foundation

extension URL {
    static func songUrl(_ artistName: String) -> URL?{
        // e.g. "jack jonson" => "jack+jonson"
        let artistNameWithPlus = artistName.replacingOccurrences(of: " ", with: "+")
        return URL(string: "https://itunes.apple.com/search?term=\(artistNameWithPlus)")
    }
}
