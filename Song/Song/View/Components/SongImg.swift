//
//  SongImg.swift
//  Song
//
//  Created by Yu on 2022/4/9.
//

import SwiftUI


struct SongImg: View {
    let urlStr:String
    let size: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: urlStr)){ phrase in
            if let img = phrase.image {
                img
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .frame(width: size)
            } else if phrase.error != nil {
                Text("🎧")
            }else{
                ProgressView()
            }
        }
        .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 5)
            
    }
}

//struct SongImg_Previews: PreviewProvider {
//    static var previews: some View {
//        SongImg()
//    }
//}
