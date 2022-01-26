//
//  ContentView.swift
//  WeSplit
//
//  Created by Yu on 2022/1/21.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var currencyFormat: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currencyCode ?? "CNY")
    }
    
    var totalPerPerson: Double {
        let tip = checkAmount * (Double(tipPercentage) / 100)
        let res = (checkAmount + tip) / Double(numberOfPeople)
        
        return res
    }
    
    var totalAmount: Double {
        let tip = checkAmount * (Double(tipPercentage) / 100)
        return checkAmount + tip
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    // checkAmount TextField
                    TextField("Enter check amount", value: $checkAmount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    // numberOfPeople Picker
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(0..<99){
                            Text("\($0)")
                        }
                    }
                }
                
                // tipPercentage Picker
                Section{
                    // segmented-style-picker
                    Picker("tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                    // scroll-view-style-picker
                    //                    Picker("tip percentage", selection: $tipPercentage){
                    //                        ForEach(0..<101){
                    //                            Text($0, format: .percent)
                    //                        }
                    //                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                // totleAmount
                Section{
                    Text(totalAmount, format: currencyFormat)
                        .foregroundColor(tipPercentage == 0 ? .red : .secondary)
                } header: {
                    Text("Total cost")
                }
                
                // totalPerPerson Text
                Section{
                    Text(totalPerPerson, format: currencyFormat)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12")
    }
}
