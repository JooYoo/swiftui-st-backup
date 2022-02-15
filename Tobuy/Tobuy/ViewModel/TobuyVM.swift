//
//  TobuyVM.swift
//  Tobuy
//
//  Created by Yu on 2022/2/15.
//

import Foundation
import RealmSwift

class TobuyVM: ObservableObject {
    
    @Published var inputVal = ""
    // retrive items
    @ObservedResults(Tobuy.self, sortDescriptor: SortDescriptor.init(keyPath: "isDone", ascending: false)) var tobuys
    
    // create item
    func addItem(){
        $tobuys.append(Tobuy(value: ["item": inputVal, "isDone": false]))
        inputVal = ""
    }
    
    // delete item
    func deleteItem(currTobuy: Tobuy){
        $tobuys.remove(currTobuy)
    }
    
    // updateItem is in ItemRowView
}
