//
//  SongVM.swift
//  Song
//
//  Created by Yu on 2022/4/7.
//

import Foundation

class SongVM: ObservableObject {
    
    
    init(){
        print("test")
        fetchSearchResults()
    }
    
    func fetchSearchResults(){
        // url
        guard let url = URL(string: "https://itunes.apple.com/search?term=jack+johnson") else{
            print("🐞 url error")
            return
        }
        
        // task
        URLSession.shared.dataTask(with: url) { data, res, err in
            
            // safe data
            guard let safeData = data, err == nil else{
                print("🐞 safe data error")
                return
            }
            
            // decode
            guard let decoded = try? JSONDecoder().decode(Search.self, from: safeData) else {
                print("🐞 decode error")
                return
            }
            
            DispatchQueue.main.async {
                print(decoded.results)
            }
            
        }.resume()
        
        
    }
    
}
