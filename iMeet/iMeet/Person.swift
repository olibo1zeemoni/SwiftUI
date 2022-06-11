//
//  Person.swift
//  iMeet
//
//  Created by Olibo moni on 21/05/2022.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit


struct Person: Identifiable, Codable, Comparable{
   
    
    
    var id: UUID
    var firstName: String
    var lastName: String
    var uiImage: UIImage
    var longitude: Double
    var latitude: Double
    
    var image: Image {
        Image(uiImage: uiImage)
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    
    enum CodingKeys: CodingKey {
        case id, firstName, lastName, uiImage, longitude, latitude
    }
    
    static func <(lhs: Person, rhs: Person)->Bool {
        lhs.lastName < rhs.lastName
    }
    
    init(firstName: String, lastName: String, id: UUID, uiImage: UIImage, longitude: Double, latitude: Double) {
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
        self.uiImage = uiImage
        self.longitude = longitude
        self.latitude = latitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        let imageData = try container.decode(Data.self, forKey: .uiImage)
        uiImage = UIImage(data: imageData)!
        longitude = try container.decode(Double.self, forKey: .longitude)
        latitude = try container.decode(Double.self, forKey: .latitude)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        let imageData = uiImage.jpegData(compressionQuality: 0.8)
        try container.encode(imageData, forKey: .uiImage)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(latitude, forKey: .latitude)
    }
    
    static let example = Person(firstName: "John", lastName: "Doe", id: UUID(), uiImage: UIImage(named: "Van")!, longitude: -0.141, latitude: 51.501)
}
