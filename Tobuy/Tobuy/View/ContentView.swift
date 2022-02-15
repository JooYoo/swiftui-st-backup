//
//  ContentView.swift
//  Tobuy
//
//  Created by Yu on 2022/2/15.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = TobuyVM()
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("What do you want to buy...", text: $vm.inputVal)
                }
                Section{
                    ForEach(vm.tobuys){ tobuy in
                        if !tobuy.isInvalidated{
                            ItemRow(tobuy: tobuy)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        vm.deleteItem(currTobuy: tobuy)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                        }
                    }
                }
            }
            .onSubmit {
                vm.addItem()
            }
            .navigationTitle("Tobuy")
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
