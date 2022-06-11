//
//  ContentView.swift
//  Project1
//
//  Created by Olibo moni on 03/04/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
