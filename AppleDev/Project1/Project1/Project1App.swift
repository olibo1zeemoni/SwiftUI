//
//  Project1App.swift
//  Project1
//
//  Created by Olibo moni on 03/04/2022.
//

import SwiftUI

@main
struct Project1App: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
