//
//  AddView.swift
//  iExpense
//
//  Created by Yu on 2022/1/30.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses:Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView{
            
            Form{
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self){ type in
                        Text(type)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save"){
                    // create new item
                    let newItem = ExpenseItem(name: name, type: type, amount: amount)
                    // add to collection
                    expenses.items.append(newItem)
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
