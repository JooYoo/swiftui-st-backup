//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Yu on 2022/2/4.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
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
                
                Button("Place order"){
                    Task{
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Order Success", isPresented: $showingConfirmation) {
            Button("Ok"){}
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        
        // MARK: - POST
        // encode order => JSON obj
        guard let encoded = try? JSONEncoder().encode(order) else{
            print("encode failed")
            return
        }
        // get request ready
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        // send request
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            // decode respinse data
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            // create alert
            confirmationMessage = "You ordered \(Order.types[decodedOrder.type]) cake x \(decodedOrder.quantity)"
            showingConfirmation = true
            
        } catch {
            print("send request error")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CheckoutView(order: Order())
        }
    }
}
