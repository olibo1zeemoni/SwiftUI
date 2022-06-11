//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Olibo moni on 28/04/2022.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @State private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
