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
                
                HStack{
                    Text("\(vm.tempMin) ~ \(vm.tempMax)")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Text(vm.description)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Weather")
        }
        .task {
            await vm.fetchData(name: "ulm")
        } 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: WeatherVM())
    }
}
