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
    
    func mergeToGetStories(_ storyIds:[Int]) -> AnyPublisher<Story, Error> {
        // limit the given ids to 50
        let storyIds = Array(storyIds.prefix(50))
        // prepare
        let firstStory = getStoryBy(storyId: storyIds[0])
        let restStoryIds = storyIds.dropFirst()
        
        // get a list of stories
        return restStoryIds
            .reduce(firstStory) { accumulator, currId in
                return accumulator
                    .merge(with: getStoryBy(storyId: currId))
                    .eraseToAnyPublisher()
            }
    }
    
    func getAllTopStories() -> AnyPublisher<[Story], Error> {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty") else {
            fatalError("Invalid URL")
        }
        
        let publisher = URLSession
            .shared
            .dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: [Int].self, decoder: JSONDecoder())
            .flatMap{ ids in
                return self.mergeToGetStories(ids)
            }
            .scan([]) { stories, story->[Story] in
                return stories + [story]
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
    
}
