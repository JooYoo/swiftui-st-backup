//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Yu on 2022/2/4.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var order = Order()
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices){ i in
                            Text(Order.types[i])
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section{
                    Toggle("Any special request?", isOn: $order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section{
                    NavigationLink{
                        AddressView(order: order)
                    }label: {
                        Text("Delivery details")
                    }
                }
                .navigationBarTitle("Cupcake")
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
