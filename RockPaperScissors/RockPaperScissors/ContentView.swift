//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Yu on 2022/1/29.
//

import SwiftUI

struct ContentView: View {
    var rpc = ["✊🏼", "✋🏼", "✌🏼"]
    
    @State private var aiChoiceIdx = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var isThisRoundWin = true
    @State private var score = 0
    @State private var round = 0
    
    
    var body: some View {
        ZStack{
            // win: red: 0.02, green: 0.77, blue: 0.42
            // lose: red: 1.00, green: 0.42, blue: 0.51
            // deuce: red: 0.20, green: 0.67, blue: 0.88
            if isThisRoundWin {
                Color(red: 0.02, green: 0.77, blue: 0.42)
                    .ignoresSafeArea()
            }else{
                Color(red: 1.00, green: 0.42, blue: 0.51)
                    .ignoresSafeArea()
            }
           
            
            VStack{
                
                Text("Round: \(round)/5")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text(rpc[aiChoiceIdx])
                    .font(.system(size: 120))
                    .padding(.vertical,20)
                    .padding(.horizontal,80)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                Text("You should \(shouldWin ? "WIN" : "LOSE")")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                
                Spacer()
                
                HStack{
                    ForEach(rpc, id: \.self) { item in
                        Button(item){
                            userTapped("\(item)")
                        }
                    }
                }
                .font(.system(size: 90))
                .buttonStyle(.bordered)
                
                Text("SCORE: \(score)")
                    .font(.system(size: 30))
                    .fontWeight(.semibold)
                    .padding(.top, 20)
                
            }
            .padding()
            .foregroundColor(.white)
            
        }
    }
    
    func userTapped(_ userChoosed: String){
        
        let aiRes = rpc[aiChoiceIdx]
        
        switch aiRes {
        case "✊🏼":
            if userChoosed == "✋🏼" {
                userShouldWinHandler()
            }else if(userChoosed == "✌🏼"){
                userShouldLoseHandler()
            }
        case "✌🏼":
            if userChoosed == "✊🏼" {
                userShouldWinHandler()
            } else if (userChoosed == "✋🏼"){
                userShouldLoseHandler()
            }
        case "✋🏼":
            if userChoosed == "✌🏼" {
                userShouldWinHandler()
            }else if(userChoosed == "✊🏼"){
                userShouldLoseHandler()
            }
        default: ()
        }
        
        // next round
        nextRound()
        
    }
    
    func userShouldWinHandler(){
        if shouldWin {
            score += 1
            isThisRoundWin = true
        }else{
            score -= 1
            isThisRoundWin = false
        }
    }
    
    func userShouldLoseHandler(){
        if !shouldWin {
            score += 1
            isThisRoundWin = true
        }else{
            score -= 1
            isThisRoundWin = false
        }
    }
    
    func nextRound(){
        round += 1
        aiChoiceIdx = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
