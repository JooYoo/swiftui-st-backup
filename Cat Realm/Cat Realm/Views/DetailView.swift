//
//  DetailView.swift
//  Cat Realm
//
//  Created by Yu on 2022/2/19.
//

import SwiftUI

struct DetailView: View {
    var breed:Breed
    
    var body: some View {
        
        ScrollView{
            VStack{
//                CatImageView(uwrappedUrlString: breed.image?.url ?? "nil")
//                    .frame(maxHeight: 250)
                ImageCacheView(url: URL(string: breed.image?.url ?? "nil"), size:.infinity)
                Text(breed.name)
                    .font(.largeTitle.bold())
                Text(breed.origin)
                    .font(.title3)
                    .padding(.bottom, 5)
                Text(breed.temperament)
                    .font(.caption)
                Divider()
                // FIXME: can't use description
                //                Text(breed.description)
                //                    .padding(.horizontal, 20)
            }
            .padding()
            .navigationTitle("Detail")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
