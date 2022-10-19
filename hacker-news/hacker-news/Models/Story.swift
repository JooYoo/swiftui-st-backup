//
//  Story.swift
//  hacker-news
//
//  Created by Yu on 18.10.22.
//

import Foundation

struct Story: Codable {
    let id: Int
    let title: String
    let url: String
}

extension Story {
    static func placeholder() -> Story{
        return Story(id: 0, title: "🍃", url: "https://google.com")
    }
}
