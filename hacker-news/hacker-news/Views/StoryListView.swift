//
//  StoryListView.swift
//  hacker-news
//
//  Created by Yu on 18.10.22.
//

import SwiftUI

struct StoryListView: View {
    @ObservedObject var vm = StoryListViewModel()
    
    var body: some View {
        
        NavigationView {
            List(self.vm.stories, id: \.id) { story in
                
                NavigationLink {
                    StoryDetailView(story.id)
                } label: {
                    Text("\(story.id)")
                }

            }
            .navigationBarTitle("Hack News")
        }
        
    }
}

struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView()
    }
}
