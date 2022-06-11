//
//  ContentView.swift
//  rollGame
//
//  Created by Olibo moni on 31/05/2022.
//

import SwiftUI


struct ContentView: View {
    
   
    @StateObject  var games : Games
    
    
    var body: some View {

            TabView {

                PlayView()
                    .tabItem {
                        Label("Play", systemImage: "dice")
                    }
                    .onTapGesture {
//                        let newGame = Game(id: UUID(), total: 0, numberOfDice: <#T##Int#>, sides: <#T##Int#>)
//                        games.add(<#T##game: Game##Game#>)
                    }
                    .tag("play")
                HistoryView()
                    .tabItem {
                        Label("History", systemImage: "list.dash")
                            
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                    .tag("settings")
            }
            .preferredColorScheme(.dark)
            
            .onAppear{
                games.loadData()
            }
            .environmentObject(games)
    }
    
    init() {
        self._games = StateObject(wrappedValue: Games())
    }
    
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
