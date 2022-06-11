//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Olibo moni on 24/04/2022.
//

import SwiftUI

@main
struct BookWormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
