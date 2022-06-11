//
//  GridView.swift
//  Moonshot
//
//  Created by Olibo moni on 05/04/2022.
//

import SwiftUI

struct GridView: View {
    
    let astronauts = Bundle.main.decode("astronauts.json") as [String: Astronaut]
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [ GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
            //NavigationView {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(missions) { mission in
                                NavigationLink {
                                    MissionView(mission: mission, astronauts: astronauts)
                                } label: {
                                    VStack {
                                        mission.image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .padding()
                                        
                                        VStack {
                                            Text(mission.displayName)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            
                                            Text(mission.formattedLaunchDate)
                                                .font(.caption)
                                                .foregroundColor(.white.opacity(0.5))
                                        }
                                        .padding(.vertical)
                                        .frame(maxWidth: .infinity)
                                        .background(.lightBackground)
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.lightBackground)
                                    }
                                }
                                
                            }
                        }
                        .padding([.horizontal ,.bottom])
                    }
                //.navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
            }
        
   // }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
