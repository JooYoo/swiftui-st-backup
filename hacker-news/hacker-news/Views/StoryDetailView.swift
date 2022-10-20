//
//  StoryDetailView.swift
//  hacker-news
//
//  Created by Yu on 19.10.22.
//

import SwiftUI

struct StoryDetailView: View {
    @ObservedObject var vm: StoryDetailViewModel
    let storyId: Int
    
    init(_ storyId: Int) {
        self.storyId = storyId
        self.vm = StoryDetailViewModel()
    }
    
    var body: some View {
        VStack {
            Text("\(vm.title)")
            WebView(url: vm.url)
        }
        .onAppear{
            vm.fetchStoryDetailsBy(self.storyId)
        }
    }
}

struct StoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailView(8863)
    }
}
