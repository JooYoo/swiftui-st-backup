//
//  ContentView.swift
//  Weather
//
//  Created by Yu on 2022/2/8.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = WeatherVM()
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                
                if vm.temp.isEmpty {
                    ProgressView()
                }else{
                    Image(systemName: vm.sfId)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .padding(.horizontal)
                    Text(vm.temp)
                        .font(.system(size: 70))
                        .fontWeight(.heavy)
                    
                    Spacer()
                    
                    Text(vm.name)
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                    Text(vm.description)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("\(vm.tempMin) ~ \(vm.tempMax)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 1)
                }
                
                Spacer()
            }
            .navigationTitle("Weather")
            .searchable(text: $vm.input)
            .disableAutocorrection(true)
            .onSubmit(of: .search) {
                Task{
                    await vm.fetchData(name: vm.input)
                    vm.input = ""
                }
            }
        }
        .navigationViewStyle(.stack)
        .task {
            await vm.fetchData(name: "Ulm")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: WeatherVM())
    }
}
