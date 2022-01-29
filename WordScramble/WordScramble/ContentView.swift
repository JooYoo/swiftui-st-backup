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
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    
    var body: some View {
        VStack{
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
                .onAppear(perform: startGame)
                .toolbar{
                    Button("New round"){
                        startGame()
                        usedWords = [String]()
                        score = 0
                    }
                }
                .alert(errorTitle, isPresented: $showingError) {
                    Button("Ok", role: .cancel){}
                } message: {
                    Text(errorMessage)
                }
                
                
            }
            Text("Score: \(score)")
                .font(.headline)
        }
    }
    
    func addNewWord(){
        
        // process user input
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // prevent input empty
        guard answer.count > 0 else { return }
        
        // valid input word
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "No repeat word input 😡")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not exist from the given word", message: "Can't spell that word from \(rootWord) 😤")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Not real word", message: "It's a fake english word 🤡")
            return
        }
        
        guard isLengthMoreThanThree(word: answer) else {
            wordError(title: "Too short", message: "please input the word more than 3 letters")
            return
        }
        
        // add to list
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        // reset TextField
        newWord = ""
        
        // add score
        score += 1
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
    
    func isOriginal(word:String)->Bool{
        !usedWords.contains(word)
    }
    
    func isPossible(word:String)->Bool{
        var tempWord = rootWord
        
        for letter in word {
            // check if current-letter exist in rootWord
            if let pos = tempWord.firstIndex(of: letter){
                // it exists, then remove to make sure this letter can't be used again
                tempWord.remove(at: pos)
            }else{
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String)->Bool{
        // 1. create a checker
        let checker = UITextChecker()
        // 2. create a range based on input-word
        let range = NSRange(location: 0, length: word.utf16.count)
        // 3. find the input-word misspelled range
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        // 4. check if misspelling exists
        return misspelledRange.location == NSNotFound
    }
    
    func isLengthMoreThanThree(word: String)->Bool{
        return word.count > 3
    }
    
    func wordError(title:String, message:String){
        errorTitle = title
        errorMessage = message
        showingError = true
        score -= 1
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
