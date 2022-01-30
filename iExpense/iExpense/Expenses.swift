import Foundation

class Expenses: ObservableObject{
    @Published var items = [ExpenseItem](){
        didSet {
            // create encoder
            let encoder = JSONEncoder()
            
            // save to UserDefaults
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        // create decoder
        let decoder = JSONDecoder()
        
        // load from UserDefaults
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decoded = try? decoder.decode([ExpenseItem].self, from: savedItems){
                items = decoded
                return
            }
        }
        
        // if nothing in UserDefaults
        items = []
    }
}
