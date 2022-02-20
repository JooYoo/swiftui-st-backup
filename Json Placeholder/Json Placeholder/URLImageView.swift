//
//  URLImageView.swift
//  Json Placeholder
//
//  Created by Yu on 2022/2/20.
//

import SwiftUI

struct URLImageView: View {
    let url: URL?
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        VStack{
            
            if let uiImage = imageLoader.uiImage {
                Image(uiImage: uiImage)
            } else {
                ProgressView()
            }
            
            
        }.task {
            await downloadImage()
        }
    }
    
    private func downloadImage() async {
        do {
            try await imageLoader.fetchImage(url)
        } catch {
            print("🐞 download image error:", error)
        }
    }
}

