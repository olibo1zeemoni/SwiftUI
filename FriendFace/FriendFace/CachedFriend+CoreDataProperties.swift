//
//  CachedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Olibo moni on 12/05/2022.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var origin: CachedUser?
    
    public  var wrappedName: String {
             name ?? "Unkwnon name"
        }
        
        public var wrappedId: UUID {
            id ?? UUID()
        }

}

extension CachedFriend : Identifiable {
    

}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
