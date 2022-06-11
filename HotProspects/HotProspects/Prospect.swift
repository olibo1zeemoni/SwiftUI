//
//  Prospect.swift
//  HotProspects
//
//  Created by Olibo moni on 24/05/2022.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var email = ""
   fileprivate (set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let saveKey = "SaveData"
    
    
    
    init() {
//        Using UserDefaults
//        if let data = UserDefaults.standard.data(forKey: saveKey) {
//            if let decodedData = try? JSONDecoder().decode([Prospect].self, from: data) {
//                people = decodedData
//                return
//            }
//
//        }
        
        people = []
    }
    
//    save to UserDefaults
//   private func save(){
//        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encoded, forKey: saveKey)
//        }
//    }
    
    func sortByName(){
        people.sort { $0.name < $1.name }
    }
    
    func sortByOther(){
        people.sort { $0.id < $1.id}
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let fileUrl = getDocumentsDirectory().appendingPathComponent("People")
        
        // if data is available, try loading it
        if let data = try? Data(contentsOf: fileUrl) {
            do {
                people = try JSONDecoder().decode([Prospect].self, from: data)
            } catch {
                print("loading error")
            }
        }
    }
    
  private  func save() {
        do {
            let fileUrl = getDocumentsDirectory().appendingPathComponent("People")
            let data = try JSONEncoder().encode(self.people)
            try data.write(to: fileUrl, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Saving error")
        }
    }
    
    func add(_ prospect: Prospect){
        people.append(prospect)
        save()
    }
    
    func delete(_ prospect: Prospect){
        guard let index = people.firstIndex(where: { $0.id == prospect.id  }) else { return }
        people.remove(at: index)
        save()
    }
    
    func removeItems(at offsets: IndexSet){
        people.remove(atOffsets: offsets)
        print("deleted at \(offsets)")
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
