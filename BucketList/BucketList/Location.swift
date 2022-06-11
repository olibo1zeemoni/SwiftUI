//
//  Location.swift
//  BucketList
//
//  Created by Olibo moni on 16/05/2022.
//

import Foundation
import CoreLocation

struct Emplacement: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coodinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Emplacement(id: UUID(), name: "Buckingham Palace", description: "Where Queen Elizabeth lives with her dorgis.", latitude: 51.501, longitude: -0.141)
    
    static func ==(lhs: Emplacement, rhs: Emplacement) -> Bool {
        lhs.id == rhs.id
    }
}
