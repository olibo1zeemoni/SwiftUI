//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Olibo moni on 17/05/2022.
//

import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        
        @Published private(set) var locations: [Emplacement]
        @Published var selectedPlace: Emplacement?
        @Published var isUnlocked = false
        @Published var showAlert = false
        @Published var alertMessage = ""
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Emplacement].self, from: data)
            }
            catch {
                locations = []
            }
        }
        
        func save(){
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection ])
            } catch {
                print("Unable to save data")
            }
        }
        
        func addLocation(){
            let newLocation = Emplacement(id: UUID(), name: "New Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Emplacement){
            guard let selectedPlace = selectedPlace else {
                return
            }

            
            if let index = locations.firstIndex(of: selectedPlace){
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
                let reason = "Please authenticate yourself to unlock your places"
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                    if success {
                        // authenticated successfully
                        Task { @MainActor in
                            self.isUnlocked = true
                            
//                            await MainActor.run {
//                                self.isUnlocked = true
//                            }
                        }
                    } else {
                        //error with biometric auth
                        Task { @MainActor in
                            self.alertMessage = "Biometric Authentication failed"
                            self.showAlert = true
                        }
                    }
                }
            } else if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                let reason = "please enter passcode to unlock Places"
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authError in
                    if success {
                        Task{ @MainActor in
                            self.isUnlocked = true
                        }
                    } else {
                        //error passcode
                    }
                }
                //no biometrics
            } else {
                //add auth method
            }
        }
    }
}
