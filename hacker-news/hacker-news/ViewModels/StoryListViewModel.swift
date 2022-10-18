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
            .map{ storyIds in
                storyIds.map{ StoryViewModel(id: $0) }
            }
            .sink(receiveCompletion: {_ in }, receiveValue: { storyViewModels in
                self.stories = storyViewModels
            })
    }
}

struct StoryViewModel {
    let id: Int
}
