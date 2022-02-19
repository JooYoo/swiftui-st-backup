//
//  CatImageView.swift
//  Cat Refactor
//
//  Created by Yu on 2022/2/19.
//

import SwiftUI

struct CatImageView: View {
    let uwrappedUrlString: String

    var body: some View {
        AsyncImage(url: URL(string: uwrappedUrlString)){ phase in
            
            if let img = phase.image{
                img
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            } else if phase.error != nil {
                Text("🐈")
                    .font(.system(size: 50))
            } else{
                ProgressView()
            }
        }
    }
}

struct CatImageView_Previews: PreviewProvider {
    static var previews: some View {
        CatImageView(uwrappedUrlString: "")
    }
}
