//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Yu on 2022/2/1.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String)->T{
        
        // 1. get URL
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("Load JSON failed: url error")
        }
        
        // 2. JSON => Date()
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Load JSON failed: Data contents error")
        }
        
        // 3. decode
        let decoder = JSONDecoder()
        // format date
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        // decode JSON
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Load JSON failed: decode error")
        }
        
        return loaded
    }
}
