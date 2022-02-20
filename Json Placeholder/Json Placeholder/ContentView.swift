//
//  ContentView.swift
//  Json Placeholder
//
//  Created by Yu on 2022/2/20.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = PhotoViewModel()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(vm.photos, id: \.id){ photo in
                    HStack{
                        
                        AsyncImage(url: URL(string: photo.thumbnailUrl)){ phrase in
                            if let img = phrase.image{
                                img
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                            } else if phrase.error != nil {
                                Text("🌠")
                                    .font(.system(size: 50))
                            } else {
                                ProgressView()
                            }
                        }
                        
                        VStack(alignment: .leading){
                            Text("\(photo.id)")
                                .font(.title3)
                            Text(photo.title)
                        }
                    }
                }
            }
            .navigationTitle("JSON Placeholder")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
