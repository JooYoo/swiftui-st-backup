//
//  Order.swift
//  Cupcake Corner
//
//  Created by Yu on 2022/2/4.
//

import Foundation

class Order: ObservableObject {
    // Content View
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published var type = 0
    @Published var quantity = 3
    @Published var specialRequestEnabled = false{
        didSet{
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    // Address View
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    // Checkout View
    var cost: Double{
        var cost = 0.0
        
        // $2/cake
        cost = Double(quantity * 2)
        // complicated cake
        cost = cost + Double(type/2)
        // extra frosting $1/cake
        if extraFrosting {
            cost = cost + Double(quantity)
        }
        // add sprinkles $0.5/cake
        if addSprinkles {
            cost = cost + Double(quantity) * 0.5
        }
        
        return cost
    }
}
