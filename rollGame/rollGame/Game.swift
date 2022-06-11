//
//  Game.swift
//  rollGame
//
//  Created by Olibo moni on 01/06/2022.
//

import Foundation

struct Game: Identifiable, Codable {
    var id = UUID()
    var total: Int = 1
    var numberOfDice: Int = 1
    var sides =  4
    
    static let example = Game(id: UUID(), total: 10, numberOfDice: 4, sides: 6)
}



@MainActor
class Games: ObservableObject {
   @Published var games: [Game] = [ Game(id: UUID(), total: 10, numberOfDice: 4, sides: 6)
    
   ]
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let fileUrl = getDocumentsDirectory().appendingPathComponent("Game")
        
        // if data is available, try loading it
        if let data = try? Data(contentsOf: fileUrl) {
            do {
                games = try JSONDecoder().decode([Game].self, from: data)
            } catch {
                print("loading error")
            }
        }
    }
    
  private  func save() {
        do {
            let fileUrl = getDocumentsDirectory().appendingPathComponent("Game")
            let data = try JSONEncoder().encode(self.games)
            try data.write(to: fileUrl, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Saving error")
        }
    }
    
    func add(_ game: Game){
        games.insert(game, at: 0)
        save()
    }
    
    func remove(at offset: IndexSet) {
        games.remove(atOffsets: offset)
        save()
    }
    
    func removeAll(){
        games.removeAll()
        save()
    }
    
    func delete(_ game: Game){
        guard let index = games.firstIndex(where: { $0.id == game.id  }) else { return }
        games.remove(at: index)
        save()
    }
    
}
