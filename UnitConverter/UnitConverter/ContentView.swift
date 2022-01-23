import SwiftUI

struct ContentView: View {
    // ui state
    @FocusState private var inputFocused: Bool
    // data state
    @State private var input = 0.0
    @State private var inputU = "mm"
    @State private var outputU = "mm"
    
    let units = ["mm", "cm", "inch", "m"]
    var res:Double {
        // input: x => mm
        var toMm = 0.0
        
        switch inputU {
        case "mm":
            toMm = input
        case "cm":
            toMm = input * 10
        case "inch":
            toMm = input * 25.4
        case "m":
            toMm = input * 1000
        default:
            toMm = 0.0
        }
        
        // output: mm => x
        var res = 0.0
        
        switch outputU {
        case "mm":
            res = toMm
        case "cm":
            res = toMm * 0.1
        case "inch":
            res = toMm * 0.039
        case "m":
            res = toMm * 0.001
        default:
            res = 0.0
        }
        
        return res
    }
    
    // formatter: double for TextField
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        NavigationView{
            Form{
                // input
                Section{
                    // value TextField
                    TextField("Enter amount", value: $input, formatter: formatter)
                        .keyboardType(.decimalPad)
                        .focused($inputFocused)
                    // unit Picker.segment
                    Picker("input unit select", selection: $inputU) {
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Input Value")
                }
                
                // output
                Section{
                    // result Text
                    Text(String(format: "%.2f", res))
                    // Picker
                    Picker("output unit picker", selection: $outputU) {
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        inputFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
