//
//  KFImageCache.swift
//  Cat Realm
//
//  Created by Yu on 2022/2/22.
//

import SwiftUI
import Kingfisher

struct KFImageCache: View {
    let urlStr: String
    let maxSize: CGFloat
    
    var body: some View {
        KFImage(URL(string: urlStr)!)
            .placeholder({
                Text("🐈")
                    .font(.system(size: 50))
            })
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .frame(maxWidth: maxSize)
            
    }
}

//struct KFImageCache_Previews: PreviewProvider {
//    static var previews: some View {
//        KFImageCache()
//    }
//}
