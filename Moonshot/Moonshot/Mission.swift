//
//  Mission.swift
//  Moonshot
//
//  Created by Yu on 2022/2/1.
//

import Foundation

struct Mission: Codable, Identifiable {
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String   
}
