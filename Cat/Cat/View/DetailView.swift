//
//  DetailView.swift
//  Cat
//
//  Created by Yu on 2022/2/11.
//

import SwiftUI

struct DetailView: View {
    var breed:Breed
    
    var body: some View {
        
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: (breed.image?.url)!)) { phase in
                    if let image = phase.image{
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                    }else if phase.error != nil{
                        Text("🐈")
                    }else{
                        ProgressView()
                    }
                }
                .frame(maxHeight: 250)
                Text(breed.name)
                    .font(.largeTitle.bold())
                Text(breed.origin)
                    .font(.title3)
                    .padding(.bottom, 5)
                Text(breed.temperament)
                    .font(.caption)
                Divider()
                
                Text(breed.description)
                    .padding(.horizontal, 20)
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
