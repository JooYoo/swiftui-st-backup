//
//  TodoVM.swift
//  Todo
//
//  Created by Yu on 2022/2/13.
//

import Foundation
import RealmSwift

class TodoVM: ObservableObject {
    
    @Published var todos = [Todo]()
    
}
