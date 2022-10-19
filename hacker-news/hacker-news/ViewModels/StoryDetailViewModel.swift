//
//  StoryDetailViewModel.swift
//  hacker-news
//
//  Created by Yu on 19.10.22.
//

import Foundation
import Combine

class StoryDetailViewModel: ObservableObject {
    @Published var story: Story!
    private var cancellable: AnyCancellable?
    var storyId: Int
    
    init(storyId: Int) {
        self.storyId = storyId
        self.cancellable = Webservice()
            .getStoryBy(storyId: self.storyId)
            .catch{_ in Just(Story.placeholder())}
            .sink(receiveCompletion: {_ in }, receiveValue: { story in
                self.story = story
            })
    }
}

extension StoryDetailViewModel {
    var title: String {
        return self.story.title
    }
    
    var url: String {
        return self.story.url
    }
}
