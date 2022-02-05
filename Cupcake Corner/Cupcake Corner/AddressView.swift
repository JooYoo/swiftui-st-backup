//
//  AddressView.swift
//  Cupcake Corner
//
//  Created by Yu on 2022/2/4.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    
    var body: some View {
        
        Form{
            Section{
                TextField("Name", text: $order.name)
                TextField("Street address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section{
                NavigationLink{
                    CheckoutView(order: order)
                } label:{
                    Button("Checkout"){}
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Address")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddressView(order: Order())
                .preferredColorScheme(.dark)
        }
        
    }
}
