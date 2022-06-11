//
//  Activity.swift
//  HabitTracking
//
//  Created by Olibo moni on 10/04/2022.
//

import Foundation
import SwiftUI
import Combine

struct Activity: Codable, Identifiable{
    var id = UUID()
   var name: String
   var detail: String
    var priority: Int
    var progress: Int
    
    var priorityImage: Image {
        if priority == 1 {
            return Image(systemName: "exclamationmark")
        } else {
           return Image(systemName: "exclamationmark.\(priority)")
        }
        
    }
    
//    init(name: String, detail: String) {
//        self.name = name
//        self.detail = detail
//    }
    
}
