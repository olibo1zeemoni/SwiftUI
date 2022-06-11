//
//  Tab.swift
//  HotProspects
//
//  Created by Olibo moni on 23/05/2022.
//

import SwiftUI

struct Tab: View {
        @State private var selectedTab = "One"
        var body: some View {
            TabView(selection: $selectedTab) {
                Text("Tab 1")
                    .onTapGesture {
                         selectedTab = "Two"
                    }
                    .tabItem {
                        Label("One", systemImage: "star")
                    }
                
                Text("Tab 2")
                    .tabItem {
                        Label("Two", systemImage: "circle")
                    }
                    .tag("Two")
            }
        }
    }

struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}
