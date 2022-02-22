//
//  ListRow.swift
//  Cat Realm
//
//  Created by Yu on 2022/2/19.
//

import SwiftUI

struct ListRow: View {
    let breed: Breed
    
    var body: some View {
        HStack{
//            CatImageView(uwrappedUrlString: breed.image?.url ?? "nil")
//                .frame(width: 100, height: 100)
//            ImageCacheView(url: URL(string: breed.image?.url ?? "nil"), size: 100.0)
            KFImageCache(urlStr: breed.image?.url ?? "nil", maxSize: 100)
            VStack(alignment: .leading){
                Text(breed.name)
                    .font(.title3.bold())
                Text(breed.temperament)
                    .font(.caption)
            }
        }
    }
}

//struct ListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ListRow()
//    }
//}
