//
//  StoryListViewModel.swift
//  hacker-news
//
//  Created by Yu on 18.10.22.
//

import Foundation
import Combine

class StoryListViewModel: ObservableObject {
    @Published var stories = [StoryViewModel]()
    private var cancellable: AnyCancellable?
    
    init(){
        fetchTopStories()
    }
    
    private func fetchTopStories(){
        
        let webservice = Webservice()
        cancellable = webservice
            .getAllTopStories()
            .map{ stories in
                stories.map{ StoryViewModel(story: $0) }
            }
            .sink(receiveCompletion: {_ in }, receiveValue: { storyViewModels in
                self.stories = storyViewModels
            })
    }
}

struct StoryViewModel {
    
    let story: Story
    
    var id: Int {
        return self.story.id
    }
    
    var title: String {
        return self.story.title
    }
    
    var url: String {
        return self.story.url
    }
}
