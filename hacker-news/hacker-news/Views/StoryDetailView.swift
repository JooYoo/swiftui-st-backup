//
//  StoryDetailView.swift
//  hacker-news
//
//  Created by Yu on 19.10.22.
//

import SwiftUI

struct StoryDetailView: View {
    @ObservedObject var vm: StoryDetailViewModel
    
    init(_ storyId: Int) {
        self.vm = StoryDetailViewModel(storyId: storyId)
    }
    
    var body: some View {
        Text("\(vm.title)")
    }
}

struct StoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailView(8863)
    }
}
