//
//  ContentView.swift
//  iExpense
//
//  Created by Yu on 2022/1/30.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(expenses.items, id: \.name){ item in
                    Text(item.name)
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button{
                    // create a fake item from struct
                    let newItem = ExpenseItem(name: "test-item", type: "dev", amount: 1)
                    // add to list
                    expenses.items.append(newItem)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func removeItem(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
