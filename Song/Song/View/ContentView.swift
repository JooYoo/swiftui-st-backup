//
//  ContentView.swift
//  Song
//
//  Created by Yu on 2022/3/27.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = SongVM()
    
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
