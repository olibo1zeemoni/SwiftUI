//
//  Friend.swift
//  FriendFace
//
//  Created by Olibo moni on 10/05/2022.
//

import Foundation

struct Friend: Codable, Hashable, Identifiable {
    let id: UUID
    var name: String
}
