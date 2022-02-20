//
//  ImageLoader.swift
//  Cat Realm
//
//  Created by Yu on 2022/2/20.
//

import Foundation
import UIKit

class ImageLoader: ObservableObject {
    @Published var uiImage: UIImage?
    private static let cache = NSCache<NSString, UIImage>()
    
    func fetchImage(_ url: URL?) async {
        // URL
        guard let url = url else{
            print("🐞 image url error")
            return
        }
        // get img from cache if possible
        if let cachedImage = Self.cache.object(forKey: url.absoluteString as NSString){
            uiImage = cachedImage
        } else {
            // Task
            let task = URLSession.shared.dataTask(with: url) { data, res, err in
                if let safeData = data {

                    // valide response
                    guard let httpResponse = res as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                        print("🐞 httpResponse")
                        return
                    }
                    
                    // convert image
                    guard let image = UIImage(data: safeData) else {
                        print("🐞 UIImage error")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        // cache image
                        Self.cache.setObject(image, forKey: url.absoluteString as NSString)
                        // => UI
                        self.uiImage = image
                    }
                }
            }
            
            task.resume()
        }
    }
}
