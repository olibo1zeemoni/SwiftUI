//
//  CachedFriend+CoreDataClass.swift
//  FriendFace
//
//  Created by Olibo moni on 12/05/2022.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(CachedFriend)
public class CachedFriend: NSManagedObject, Decodable {
    
    enum CodingKeys: CodingKey {
        case id, name
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        // get the context and the entity in the context
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context [for entity Friend]") }
        guard let entity = NSEntityDescription.entity(forEntityName: "Friend", in: context) else { fatalError("Could not get entity [for entity Friend]") }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
    }

}
