//
//  MapView.swift
//  iMeet
//
//  Created by Olibo moni on 23/05/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    var person: Person
    //var location: CLLocationCoordinate2D
    //var title: String
    var span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
     private var mapRegion: MKCoordinateRegion {
         return MKCoordinateRegion(center: person.coordinate, span: span)
    }
   
    var body: some View {
        Map(coordinateRegion: .constant(mapRegion), annotationItems: [person]) { person in
            MapAnnotation(coordinate: person.coordinate) {
                VStack {
                   Image(systemName: "drop.circle")
                        .foregroundColor(.red)
                       //.stroke(.red, lineWidth: 3)
                   .frame(width: 44)
                    Text("\(person.firstName) \(person.lastName)")
                        .font(.largeTitle)
                       .foregroundColor(.red)
               }
            }
        }
    }
    
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(person: Person.example)
    }
}


