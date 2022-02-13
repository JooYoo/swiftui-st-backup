//
//  TodoApp.swift
//  Todo
//
//  Created by Yu on 2022/2/12.
//

import SwiftUI
import RealmSwift

@main
struct TodoApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.realmConfiguration, Realm.Configuration())
        }
    }
}
