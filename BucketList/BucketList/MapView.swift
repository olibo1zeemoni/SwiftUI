//
//  MapView.swift
//  BucketList
//
//  Created by Olibo moni on 16/05/2022.
//
import MapKit
import SwiftUI

struct MapView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of london", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $mapRegion, annotationItems: locations){ location in
                //MapMarker(coordinate: location.coordinate, tint: .red)
                MapAnnotation(coordinate: location.coordinate) {
                    NavigationLink{
                        Text(location.name)
                    } label: {
                         VStack {
                            Image(systemName: "drop.circle")
                                 .foregroundColor(.red)
                                //.stroke(.red, lineWidth: 3)
                            .frame(width: 44)
                            Text(location.name)
                                .foregroundColor(.red)
                        }
                    }
                   
                }
            }
            .navigationTitle("Navigation Explorer")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}


struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}
