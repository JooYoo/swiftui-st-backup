//
//  ItemRow.swift
//  Tobuy
//
//  Created by Yu on 2022/2/15.
//

import SwiftUI
import RealmSwift

struct ItemRow: View {
    @ObservedRealmObject var tobuy: Tobuy
    
    var body: some View {
        HStack{
            if tobuy.isDone {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.green)
            }else{
                Image(systemName: "circle")
                    .foregroundColor(.yellow)
            }
            Text(tobuy.item)
        }
        .onTapGesture {
            $tobuy.isDone.wrappedValue = !$tobuy.isDone.wrappedValue
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(tobuy: Tobuy())
    }
}
