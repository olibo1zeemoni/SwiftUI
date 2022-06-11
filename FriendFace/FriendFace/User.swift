//
//  User.swift
//  FriendFace
//
//  Created by Olibo moni on 10/05/2022.
//

import Foundation

struct User: Codable, Hashable, Identifiable {
    let id: UUID
    var name: String
    var age: Int
    var isActive: Bool
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
    
    
}

