//
//  AstronautView.swift
//  Moonshot
//
//  Created by Yu on 2022/2/2.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView{
            VStack{
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom)
                
                Text(astronaut.description)
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }
        }
        .navigationBarTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts:[String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts["white"]!)
    }
}
