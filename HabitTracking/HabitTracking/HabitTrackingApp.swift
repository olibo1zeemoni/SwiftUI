//
//  HabitTrackingApp.swift
//  HabitTracking
//
//  Created by Olibo moni on 10/04/2022.
//

import SwiftUI

@main
struct HabitTrackingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(activities: Activities(), activity: Activities().activities.first ?? Activity(name: "", detail: "", priority: 0, progress: 0))
        }
    }
}
