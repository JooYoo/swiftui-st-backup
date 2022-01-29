//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Yu on 2022/1/29.
//

import SwiftUI

struct ContentView: View {
    let rpc = ["✊🏼", "✋🏼", "✌🏼"].shuffled()
    
    @State private var aiChoiceIdx = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    // TODO: user choose Index
    
    
    var body: some View {
        ZStack{
            // win: red: 0.02, green: 0.77, blue: 0.42
            // lose: red: 1.00, green: 0.42, blue: 0.51
            Color(red: 0.02, green: 0.77, blue: 0.42)
                .ignoresSafeArea()
        
        VStack{
            
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
                Button("✊🏼"){}
                Button("✌🏼"){}
                Button("✋🏼"){}
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
