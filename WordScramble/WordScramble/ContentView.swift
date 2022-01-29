//
//  ContentView.swift
//  WordScramble
//
//  Created by Yu on 2022/1/28.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
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
        .onAppear(perform: startGame)
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
    
    func startGame()  {
        // 1. find the txt url in Bundle
        if let txtUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            // 2. load the txt into a string
            if let txtAsString = try? String(contentsOf: txtUrl){
                // 3. string => array
                let allWords = txtAsString.components(separatedBy: "\n")
                
                // 4. pick a word random
                rootWord = allWords.randomElement() ?? "abcdefgh"
                
                // 5. all ok => done
                return
            }
        }
        
        // somthing wrong
        fatalError("Load words failed")
    }
    
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
