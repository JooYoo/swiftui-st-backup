//
//  MissionView.swift
//  Moonshot
//
//  Created by Yu on 2022/2/2.
//

import SwiftUI

struct MissionView: View {
    
    // new struct for merge from mission and [astronaut]
    struct CrewMember{
        let role: String
        let astronaut: Astronaut
    }
    
    // new collection
    let crew: [CrewMember]
    
    // fill the data into crew whil View create
    init(mission:Mission, astronauts:[String:Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map{ member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            }else{
                fatalError("data merge erro")
            }
        }
    }
    
    
    let mission: Mission
    
    var body: some View {
        
        GeometryReader{geo in
            ScrollView{
                VStack{
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.6)
                        .padding(.top)
                    
                    Divider()
                    
                    VStack(alignment: .leading){
                        Text("Mission Highlight")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        Divider()
                        
                        Text("Crew")
                            .font(.title.bold())
                    }
                    .padding(.horizontal)
                    
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(crew, id: \.role){ member in
                                NavigationLink{
                                    AstronautView(astronaut: member.astronaut)
                                } label:{
                                    HStack{
                                        Image(member.astronaut.id)
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .frame(width: 120, height: 120)
                                            .overlay(
                                                Circle()
                                                    .stroke(.white, lineWidth: 1)
                                            )
                                        
                                        VStack(alignment:.leading){
                                            Text(member.role)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text(member.astronaut.name)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .padding(.horizontal)
                                    
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
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
    static var astronauts:[String:Astronaut] = Bundle.main
        .decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
