//
//  Mission.swift
//  Moonshot
//
//  Created by Olibo moni on 04/04/2022.
//

import Foundation
import SwiftUI


struct Mission: Codable, Identifiable {
    let id: Int
    let crew: [CrewRole]
    let launchDate: Date?
    let description: String
    
    var image: Image {
        Image("apollo\(id)")
    }
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "NA"
    }
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    


}
