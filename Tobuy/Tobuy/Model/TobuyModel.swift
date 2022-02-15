//
//  TobuyModel.swift
//  Tobuy
//
//  Created by Yu on 2022/2/15.
//

import Foundation
import RealmSwift

class Tobuy: Object, Identifiable {
    @Persisted (primaryKey: true) var id: ObjectId
    @Persisted var item: String = ""
    @Persisted var isDone: Bool = false
}
