//
//  ContentView.swift
//  iExpense
//
//  Created by Yu on 2022/1/30.
//

import SwiftUI

struct SectionForEach: View {
    var items: [ExpenseItem]
    
    var body: some View {
        ForEach(items, id: \.id){ item in
            HStack{
                VStack(alignment: .leading){
                    Text(item.name)
                        .font(.headline)
                    Text(item.type)
                }
                Spacer()
                Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    .foregroundColor(item.amount<10 ? .green : item.amount<100 ? .yellow : .red)
            }
        }
    }
}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    private var businessItems: [ExpenseItem] {
        return expenses.items.filter { $0.type == "Business" }
    }
    private var personalItems: [ExpenseItem] {
        return expenses.items.filter { $0.type == "Personal" }
    }
    
    var body: some View {
        NavigationView{
            List{
                // TODO: remove this section
                Section{
                    ForEach(expenses.items, id: \.id){ item in
                        HStack{
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                .foregroundColor(item.amount<10 ? .green : item.amount<100 ? .yellow : .red)
                        }
                    }
                    .onDelete(perform: removeItem)
                }
                // FIXME: add onDelete
                Section {
                    SectionForEach(items: personalItems)
                }
                // FIXME: add onDelete
                Section{
                    SectionForEach(items: businessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button{
                    // show AddView
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
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
