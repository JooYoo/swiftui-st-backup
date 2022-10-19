//
//  Webservice.swift
//  hacker-news
//
//  Created by Yu on 18.10.22.
//

import Foundation
import Combine

class Webservice {
    
    func getStoryBy(storyId: Int) -> AnyPublisher<Story, Error> {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(storyId).json?print=pretty") else {
            fatalError("url invalid")
        }
        
        let publisher = URLSession
            .shared
            .dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: Story.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        return publisher
    }
    
    func getAllTopStories() -> AnyPublisher<[Int], Error> {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty") else {
            fatalError("Invalid URL")
        }
        
        let publisher = URLSession
            .shared
            .dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: [Int].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        return publisher
    }
    
}
