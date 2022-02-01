//
//  ContentView.swift
//  Moonshot
//
//  Created by Yu on 2022/1/31.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        VStack{
            Text("astronaut \(astronauts.count)")
                .padding()
            Text("missions \(missions.count)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
