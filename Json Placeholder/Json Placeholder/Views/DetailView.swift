//
//  DetailView.swift
//  Json Placeholder
//
//  Created by Yu on 2022/2/24.
//

import SwiftUI

struct DetailView: View {
    let photo: Photo
    
    var body: some View {
        ScrollView{
            
            VStack{
                ImageView(photo: photo, sizeWidth: .infinity, sizeHeight: 300)
                Text(photo.title)
                    .font(.title3)
            }
            .padding()
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
