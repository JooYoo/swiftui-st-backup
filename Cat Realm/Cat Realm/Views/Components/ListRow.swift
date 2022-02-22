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
