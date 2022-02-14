//
//  ListItem.swift
//  Todo
//
//  Created by Yu on 2022/2/14.
//

import SwiftUI

struct ListItem: View {
    let todo:Todo
    
    var body: some View {
        Text(todo.txt)
            .strikethrough(todo.isDone)
            .padding(.vertical, 15)
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(todo: Todo())
    }
}
