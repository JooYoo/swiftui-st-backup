//
//  ContentView.swift
//  GuessFlag
//
//  Created by Yu on 2022/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
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
                        // flag tapped
                        flagTapped(number)
                    } label:{
                        Image(countries[number])
                            .renderingMode(.original)
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score: \(score).")
        }
        
    }
    
    func flagTapped(_ number: Int)  {
        if correctAnswer == number {
            scoreTitle = "Correct"
            score += 1
        }else{
            scoreTitle = "Wrong"
            score -= 1
        }
        
        showingScore = true
    }
    
    func askQuestion(){
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
