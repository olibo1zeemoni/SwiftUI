//
//  CachedUser+CoreDataClass.swift
//  FriendFace
//
//  Created by Olibo moni on 12/05/2022.
//
//

import Foundation
import CoreData

@objc(CachedUser)
public class CachedUser: NSManagedObject, Decodable {
    
    enum CodingKeys: CodingKey {
        case id, registered, name, age, isActive, company, email, address, about, friends, tags
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        // get the context and the entity in the context
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context [for entity Friend]") }
        guard let entity = NSEntityDescription.entity(forEntityName: "Friend", in: context) else { fatalError("Could not get entity [for entity Friend]") }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        registered = try container.decode(Date.self, forKey: .registered)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int16.self, forKey: .age)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        company = try container.decode(String.self, forKey: .company)
        email = try container.decode(String.self, forKey: .email)
        about = try container.decode(String.self, forKey: .about)
        let friendArray = try container.decode([Friend].self, forKey: .friends) //get friends
        cachedFriends = NSSet(array: friendArray)                                 // convert to NSSet
        
        tags = try container.decode([String].self, forKey: .tags)
        
    }

}
