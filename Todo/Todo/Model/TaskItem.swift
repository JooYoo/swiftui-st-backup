//
//  TaskItem.swift
//  Todo
//
//  Created by Yu on 2022/2/12.
//

import RealmSwift
import SwiftUI

class TaskItem: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var taskTitle: String
    @Persisted var taskDate: Date = Date()
    @Persisted var taskStatus: TaskStatus = .pending
    
}

enum TaskStatus:String, PersistableEnum {
    case missed="Missed"
    case completed = "Completed"
    case pending = "Pending"
}
