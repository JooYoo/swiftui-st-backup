//
//  ImageLoader.swift
//  Json Placeholder
//
//  Created by Yu on 2022/2/20.
//

import Foundation
import UIKit


enum NetworkError: Error{
    case badRequest
    case unsupportedImage
    case badUrl
}

@MainActor
class ImageLoader: ObservableObject {
    @Published var uiImage: UIImage?
    private static let cache = NSCache<NSString, UIImage>()
    
    func fetchImage(_ url: URL?) async throws {
        // 1. URL
        guard let url = url else{
            throw NetworkError.badUrl
        }
        
        // 2. TODO: Task
        let request = URLRequest(url: url)
        
        if let cachedImage = Self.cache.object(forKey: url.absoluteString as NSString){
            uiImage = cachedImage
        } else {
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                throw NetworkError.badRequest
            }
            
            guard let image = UIImage(data: data) else {
                throw NetworkError.unsupportedImage
            }
            
            // cache the image
            Self.cache.setObject(image, forKey: url.absoluteString as NSString)
            
            uiImage = image
        }
    }
}
