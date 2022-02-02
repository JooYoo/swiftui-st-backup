//
//  MissionView.swift
//  Moonshot
//
//  Created by Yu on 2022/2/2.
//

import SwiftUI

struct MissionView: View {
    var mission: Mission
    
    var body: some View {
        
        GeometryReader{geo in
            ScrollView{
                VStack{
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.6)
                        .padding(.top)
                    
                    VStack(alignment: .leading){
                        
                        Text("Mission Highlight")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                    }
                    .padding(.horizontal)
                    
                }
                .padding(.bottom)
            }
        }
        .navigationBarTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
        
    }
}

struct MissionView_Previews: PreviewProvider {
    static var missions:[Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        MissionView(mission: missions[0])
            .preferredColorScheme(.dark)
    }
}
