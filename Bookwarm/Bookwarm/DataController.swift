//
//  DataController.swift
//  Bookwarm
//
//  Created by Yu on 2022/2/5.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    // create Container with store name
    let container = NSPersistentContainer(name: "Bookworm")
    
    // load data when instance is created
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData load store Error: \(error.localizedDescription)")
            }
        }
    }
}
