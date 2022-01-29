//
//  ContentView.swift
//  WordScramble
//
//  Created by Yu on 2022/1/28.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = "RootWord"
    @State private var newWord = ""
    
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
                Section{
                    ForEach(usedWords, id: \.self) { word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .onSubmit(addNewWord)
            .navigationTitle(rootWord)
        }
    }
    
    func addNewWord(){
        
        // process user input
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // prevent input empty
        guard answer.count > 0 else { return }
        
        // add to list
        usedWords.insert(answer, at: 0)
        
        // reset TextField
        newWord = ""
    }
    
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
