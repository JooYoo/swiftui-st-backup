//
//  ContentView.swift
//  GuessFlag
//
//  Created by Yu on 2022/1/24.
//

import SwiftUI

struct ContentView: View {
    
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        
        ZStack{
            Color.blue
                .ignoresSafeArea()
            
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag")
                    Text(countries[correctAnswer])
                }.foregroundColor(.white)
                
                ForEach (0..<3) { number in
                    Button{
                        // TODO: flag tapped
                    } label:{
                        Image(countries[number])
                            .renderingMode(.original)
                    }
                }
            }
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
