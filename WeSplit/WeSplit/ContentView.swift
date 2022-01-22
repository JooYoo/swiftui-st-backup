//
//  ContentView.swift
//  WeSplit
//
//  Created by Yu on 2022/1/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let tip = checkAmount * (Double(tipPercentage) / 100)
        let res = (checkAmount + tip) / Double(numberOfPeople)
        
        return res
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    // checkAmount TextField
                    TextField("Enter check amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "CNY"))
                        .keyboardType(.decimalPad)
                    // numberOfPeople Picker
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(0..<99){
                            Text("\($0)")
                        }
                    }
                }
                
                // tipPercentage Picker
                Section{
                    Picker("tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                // totalPerPerson Text
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "CNY"))
                }
            }.navigationTitle("WeSplit")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12")
    }
}
