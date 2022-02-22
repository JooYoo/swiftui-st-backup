//
//  ContentView.swift
//  Json Placeholder
//
//  Created by Yu on 2022/2/20.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @StateObject var vm = PhotoViewModel()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(vm.photos, id: \.id){ photo in
                    HStack{

                        KFImage(URL(string: photo.thumbnailUrl)!)
                            .placeholder({
                                ProgressView()
                            })
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
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
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
