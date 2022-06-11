//
//  ContentView.swift
//  HotProspects
//
//  Created by Olibo moni on 23/05/2022.
//


import SwiftUI
import UserNotifications


struct ContentView: View {
    @StateObject var prospects = Prospects()
    
    var body: some View {
        TabView {
            ProspectsView(showIcon: .yes, filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                    
                }
            ProspectsView(showIcon: .no, filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(showIcon: .no, filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
        .onAppear{
            prospects.loadData()
            
        }
        .environmentObject(prospects)
    }
}
   

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
