//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Olibo moni on 10/05/2022.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    @State private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
