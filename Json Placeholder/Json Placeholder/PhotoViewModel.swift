//
//  PhotoViewModel.swift
//  Json Placeholder
//
//  Created by Yu on 2022/2/20.
//

import Foundation

class PhotoViewModel: ObservableObject {
    
    @Published var photos = [Photo]()
    @Published var count = 0
    
    init(){
        Task{
            await fetchPhotos()
        }
    }
    
    // MARK: - Networking
    func fetchPhotos() async{
        // 1. URL
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos?_start=\(count)&_limit=10") else {
            print("🐞 url error")
            return
        }
        
        // 2. Task
        let task = URLSession.shared.dataTask(with: url) { data, res, err in
            // 3. decoding
            do {
                if let safeData = data{
                    
                    let apiPhotos = try JSONDecoder().decode([Photo].self, from: safeData)
                    
                    let oldPhotos = self.photos
                    
                    DispatchQueue.main.async {
                        self.photos = oldPhotos + apiPhotos
                        self.count += 10
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
