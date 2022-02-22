//
//  ListItem.swift
//  Json Placeholder
//
//  Created by Yu on 2022/2/22.
//

import SwiftUI

struct ListItem: View {
    var photo: Photo
    var isLast: Bool
    @ObservedObject var vm: PhotoViewModel
    
    var body: some View {
        HStack{
            //                        KFImage(URL(string: photo.thumbnailUrl)!)
            //                            .placeholder({
            //                                ProgressView()
            //                            })
            //                            .resizable()
            //                            .scaledToFit()
            //                            .frame(width: 100, height: 100)
            AsyncImage(url: URL(string: photo.thumbnailUrl)){ phrase in
                if let img = phrase.image {
                    img
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                } else if phrase.error != nil {
                    Text("🐈")
                        .font(.system(size: 30))
                }else{
                    ProgressView()
                }
            }
            
            VStack(alignment: .leading){
                Text("\(photo.id)")
                    .font(.title3)
                Text(photo.title)
                if self.isLast{
                    ProgressView()
                        .task {
                            await self.vm.fetchPhotos()
                        }
                }
            }
        }
        .padding(.top, 10)
    }
}

//struct ListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        ListItem()
//    }
//}
