
import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var resultSleepTime = ""
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var getSleepTime: String{
        do {
            // config Model
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            // get wakeUp time as seconds
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            // get prediction
            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            // res
            let sleepTime = wakeUp - prediction.actualSleep
            
            // res
            return sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            fatalError("Predict error")
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack{
                
                Form{
                    Section{
                        DatePicker("Please enter a time:", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    } header:{
                        Text("When do you want to wake up?")
                            .font(.headline)
                    }
                    
                    Section(header: Text("Desired amount of sleep").font(.headline)){
                        Stepper("\(sleepAmount.formatted())", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                    
                    Section(header: Text("Daily coffee intake").font(.headline)){
                        // Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                        
                        Picker("coffee amount:", selection: $coffeeAmount) {
                            ForEach(0..<21){ nr in
                                Text("\(nr)")
                            }
                        }
                    }
                    
                }
                .navigationTitle("Better Rest")
                .toolbar {
                    Button("Calculate", action: calculateBedtime)
                }
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK"){}
                } message: {
                    Text(alertMessage)
                }
               
                Text("Bed Time: \(getSleepTime)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
        }
    }
    
    func calculateBedtime() {
        do {
            // config Model
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            // get wakeUp time as seconds
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            // get prediction
            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            // res
            let sleepTime = wakeUp - prediction.actualSleep
            
            // display res in alert
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
            // pass to resultSleepTime
            resultSleepTime = alertMessage
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry error"
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
