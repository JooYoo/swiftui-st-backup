//
//  ImageCacheView.swift
//  Cat Realm
//
//  Created by Yu on 2022/2/20.
//

import SwiftUI

struct ImageCacheView: View {
    @StateObject private var imageLoader = ImageLoader()
    
    let url: URL?
    let size: CGFloat
    
    var body: some View {
        VStack{
            
            if let uiImage = imageLoader.uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: size)
            } else {
                Text("🐈")
                    .font(.system(size: 20))
            }
        }.task {
            await imageLoader.fetchImage(url)
        }

    }
}

//struct ImageCacheView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageCacheView()
//    }
//}
