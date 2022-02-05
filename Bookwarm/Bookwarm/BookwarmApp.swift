//
//  BookwarmApp.swift
//  Bookwarm
//
//  Created by Yu on 2022/2/5.
//

import SwiftUI

@main
struct BookwarmApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
