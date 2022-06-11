//
//  DataController.swift
//  BookWorm
//
//  Created by Olibo moni on 24/04/2022.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "BookWorm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load \(error.localizedDescription)")
            }
        }
    }
}
