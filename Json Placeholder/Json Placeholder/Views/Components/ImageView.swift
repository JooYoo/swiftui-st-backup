//
//  ImageView.swift
//  Json Placeholder
//
//  Created by Yu on 2022/2/24.
//

import SwiftUI

struct ImageView: View {
    
    let photo: Photo
    let sizeWidth: CGFloat
    let sizeHeight: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: photo.thumbnailUrl)){ phrase in
            if let img = phrase.image {
                img
                    .resizable()
                    .scaledToFit()
                    .frame(width: sizeWidth, height: sizeHeight)
            } else if phrase.error != nil {
                Text("🐈")
                    .font(.system(size: 30))
            }else{
                ProgressView()
            }
        }
    }
}

//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageView()
//    }
//}
