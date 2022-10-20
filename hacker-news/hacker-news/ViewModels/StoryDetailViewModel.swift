//
//  StoryDetailViewModel.swift
//  hacker-news
//
//  Created by Yu on 19.10.22.
//

import Foundation
import Combine

class StoryDetailViewModel: ObservableObject {
    @Published var story: Story! = Story.placeholder()
    private var cancellable: AnyCancellable?
    
    func fetchStoryDetailsBy(_ id: Int) {
        cancellable = Webservice()
            .getStoryBy(storyId: id)
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
