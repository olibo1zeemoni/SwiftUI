//
//  Favorites.swift
//  SnowSneaker
//
//  Created by Olibo moni on 06/06/2022.
//

import Foundation

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>
    
    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"
    
    init() {
        // load our saved data
        
        if let array = UserDefaults.standard.object(forKey: saveKey) as? [String]{
            let setToLoad = Set(array)
            resorts = setToLoad
        } else {
            
        
        // still here? Use an empty array
        resorts = []
        }
    }
    
    // returns true if our set contains this resort
       func contains(_ resort: Resort) -> Bool {
           resorts.contains(resort.id)
       }

       // adds the resort to our set, updates all views, and saves the change
       func add(_ resort: Resort) {
           objectWillChange.send()
           resorts.insert(resort.id)
           save()
       }

       // removes the resort from our set, updates all views, and saves the change
       func remove(_ resort: Resort) {
           objectWillChange.send()
           resorts.remove(resort.id)
           save()
       }

       func save() {
           // write out our data
           objectWillChange.send()
           let arrayToSave = Array(resorts)
           UserDefaults.standard.set(arrayToSave, forKey: saveKey)
       }
}
