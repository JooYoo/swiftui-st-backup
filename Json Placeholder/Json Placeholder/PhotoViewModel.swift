//
//  PhotoViewModel.swift
//  Json Placeholder
//
//  Created by Yu on 2022/2/20.
//

import Foundation

class PhotoViewModel: ObservableObject {
    
    @Published var photos = [Photo]()
    
    init(){
        Task{
            await fetchPhotos()
        }
    }
    
    // MARK: - Networking
    func fetchPhotos() async{
        // 1. URL
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos?_start=0&_limit=300") else {
            print("🐞 url error")
            return
        }
        
        // 2. Task
        let task = URLSession.shared.dataTask(with: url) { data, res, err in
            // 3. decoding
            do {
                if let safeData = data{
                    
                    let apiPhotos = try JSONDecoder().decode([Photo].self, from: safeData)
                    
                    DispatchQueue.main.async {
                        self.photos = apiPhotos
                    }
                    
                }
            } catch  {
                print("🐞 decoding error:", error)
            }
        }
        // 4. start task
        task.resume()
    }
    
    
}
