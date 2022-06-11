//
//  CachedUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Olibo moni on 12/05/2022.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var registered: Date?
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var isActive: Bool
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var tags: [String]?
    @NSManaged public var cachedFriends: NSSet?
    
    public var wrappedId: UUID {
            id ?? UUID()
        }
        
        public var wrappedDate: Date {
            registered ?? Date.now
        }
        
        public var wrappedName: String {
            name ?? "Unknown Name"
        }
        
        public var wrappedCompany: String {
            company ?? "Unknown company"
        }
        
        public var wrappedEmail: String {
            company ?? "Unknown email"
        }
        
        public var wrappedAddress: String {
            address ?? "Unkwown address"
        }
        
        public var wrappedAbout: String {
            about ?? "Unkwown address"
        }
        
        public var cachedFriendArray: [CachedFriend] {
            let set = cachedFriends as? Set<CachedFriend> ?? []
            
            return set.sorted {
                $0.wrappedName < $1.wrappedName
            }
        }
    
    public var wrappedTags: [String] {
        tags ?? [String]()
    }

}

// MARK: Generated accessors for cachedFriend
extension CachedUser {

    @objc(addCachedFriendObject:)
    @NSManaged public func addToCachedFriend(_ value: CachedFriend)

    @objc(removeCachedFriendObject:)
    @NSManaged public func removeFromCachedFriend(_ value: CachedFriend)

    @objc(addCachedFriend:)
    @NSManaged public func addToCachedFriend(_ values: NSSet)

    @objc(removeCachedFriend:)
    @NSManaged public func removeFromCachedFriend(_ values: NSSet)

}

extension CachedUser : Identifiable {
      

}
