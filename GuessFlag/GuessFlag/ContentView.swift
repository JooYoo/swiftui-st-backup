//
//  ContentView.swift
//  GuessFlag
//
//  Created by Yu on 2022/1/24.
//

import SwiftUI

// view composition
struct FlagImage: View {
    var flageName: String
    
    var body: some View{
        Image(flageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

// custom modifier
struct BigYellowTxt: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.yellow)
    }
}

extension View {
    func bigYellowTxt() -> some View{
        modifier(BigYellowTxt())
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userTappedNr = 0
    @State private var round = 0
    
    var body: some View {
        
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),],
                           center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack{
                
                Text("Guess flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                Spacer()
         
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .bigYellowTxt()
                    }
                    
                    ForEach (0..<3) { number in
                        Button{
                            // flag tapped
                            flagTapped(number)
                        } label:{
                            FlagImage(flageName: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                
                Text("Score: \(score)")
                    .font(.title.weight(.bold))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if round == 3 {
                Text("Over: your socre \(score)")
            }else{
                Text("That’s the flag of \(countries[userTappedNr])")
            }
        }
        
    }
    
    func flagTapped(_ number: Int)  {
        // count round
        round += 1
       print(round)
        // calc score
        if correctAnswer == number {
            scoreTitle = "Correct"
            score += 1
        }else{
            scoreTitle = "Wrong"
            score -= 1
        }
        
        // update user tapped
        userTappedNr = number
        // present alert()
        showingScore = true
    }
    
    func askQuestion(){
        // check if end
        if round == 3 {
            score = 0
            round = 0
        }
        // shuffle data
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
