//
//  ListView.swift
//  Moonshot
//
//  Created by Olibo moni on 05/04/2022.
//

import SwiftUI

struct ListView: View {
    
    let astronauts = Bundle.main.decode("astronauts.json") as [String: Astronaut]
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [ GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        List{
            ForEach(missions) { mission in
                NavigationLink{
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        VStack(alignment: .leading){
                            Text(mission.displayName)
                            Spacer()
                            Text(mission.launchDate?.formatted(date: .long, time: .omitted) ?? "NA")
                        }
                        
                        Spacer()
                        
                        mission.image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 60)
                        
                    }
                    .background(.darkBackground)
                    
                }
                .listRowBackground(Color.darkBackground)
                
            }
            
        }
        .padding(.top)
        .listStyle(PlainListStyle())
        .background(.darkBackground)
        .frame(maxWidth: .infinity)
        .preferredColorScheme(.dark)
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}


//{
//    //NavigationView {
//    ScrollView {
//        LazyVStack {
//
//            ForEach(missions) { mission in
//                NavigationLink {
//                    MissionView(mission: mission, astronauts: astronauts)
//                } label: {
//                    Group {
//                        VStack(alignment: .leading) {
//                            HStack(alignment: .center) {
//
//                                VStack {
//                                    Text(mission.displayName)
//                                        .font(.headline)
//                                        .foregroundColor(.white)
//                                        .padding()
//
//
//                                    Text(mission.formattedLaunchDate)
//                                        .font(.caption)
//                                        .foregroundColor(.white)
//                                }
//                                //.padding(.vertical)
//                                // .frame(maxWidth: .infinity)
//                                //.background(.lightBackground)
//
//                                Spacer()
//
//                                mission.image
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 80, height: 80)
//
//                            }
//                            Rectangle()
//                                .frame(height: 2)
//                                .foregroundColor(.lightBackground)
//                                //.padding(.vertical)
//                        }
//
//                        .padding(.horizontal)
//
//                    }
//
//
//                }
//
//            }
//        }
//        //.listRowBackground(Color.darkBackground)
//
//
//    }
//    .background(.darkBackground)
//    .preferredColorScheme(.dark)
//}
