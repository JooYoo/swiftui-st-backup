//
//  ContentView.swift
//  Json Placeholder
//
//  Created by Yu on 2022/2/20.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @StateObject var vm = PhotoViewModel()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(0..<vm.photos.count, id: \.self){ i in
                    
                    NavigationLink{
                        Text(vm.photos[i].title)
                    } label: {
                        if i == vm.photos.count - 1 {
                            ListItem(photo: vm.photos[i], isLast: true, vm: self.vm)
                        } else {
                            ListItem(photo: vm.photos[i], isLast: false, vm: self.vm)
                        }
                    }
                    
                    
                }
            }
            .navigationTitle("JSON Placeholder")
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
