//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Yu on 2022/2/4.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3){ image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame( height: 233)
                
                Text("Your total cost: \(order.cost, format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                    .font(.title)
                
                Button("Place order"){}
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CheckoutView(order: Order())
        }
    }
}
