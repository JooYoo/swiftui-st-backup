//
//  TobuyApp.swift
//  Tobuy
//
//  Created by Yu on 2022/2/15.
//

import SwiftUI
import RealmSwift

@main
struct TobuyApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.realmConfiguration, Realm.Configuration())
        }
    }
}
