//
//  MissionView.swift
//  Moonshot
//
//  Created by Olibo moni on 05/04/2022.
//

import SwiftUI

struct MissionView: View {
    
    let mission: Mission
    let astronauts : [String: Astronaut]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    mission.image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    HStack(alignment: .center) {
                        Text("Launch Date :")
                        Text(mission.launchDate?.formatted(date: .long, time: .omitted) ?? "NA")
                    }
                    
                    VStack(alignment: .leading) {
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                    }
                    .padding(.horizontal)
                    
                    CrewView(mission: mission, astronauts: astronauts)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts : [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}


