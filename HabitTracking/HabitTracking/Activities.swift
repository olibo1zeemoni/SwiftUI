//
//  Activities.swift
//  HabitTracking
//
//  Created by Olibo moni on 11/04/2022.
//

import Foundation

  class Activities: ObservableObject {
      private static let savedKey = "SavedData"
      @Published var activities = [Activity]() {
          didSet {
                      // save data each time the content of the array is modified:
                      // addition, removal, but also when modifying an element of the array
                      if let encoded = try? JSONEncoder().encode(activities) {
                          UserDefaults.standard.set(encoded, forKey: Activities.savedKey)
                      }
                  }
      }

    static var singleton = Activities()

    init(){
        if let data = UserDefaults.standard.data(forKey: Activities.savedKey) {
                if let decoded = try? JSONDecoder().decode([Activity].self, from: data) {
                    self.activities = decoded
                    return
                }
            }
        activities = []
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(activities) {
            UserDefaults.standard.set(encoded, forKey: Activities.savedKey)
            objectWillChange.send()
        }
    }
      
      func update(activity: Activity) {
          
      }
}
