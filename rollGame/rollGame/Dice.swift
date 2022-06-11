//
//  File.swift
//  rollGame
//
//  Created by Olibo moni on 31/05/2022.
//

import Foundation
import SwiftUI

struct Dice: Identifiable {
    var id = UUID()
    var sides: Int
    
    var image: Image {
        Image(systemName: "die.face.\(sides).fill")
    }
    
    var total: Array<Int> {
        var array: [Int] = []
        for i in 1...sides {
            array.append(i)
        }
        return array
    }
    
    var faces: [Image] {
        var array: [Image] = []
        for i in 1...sides {
            let image = Image(systemName: "die.face.\(i).fill")
            array.append(image)
        }
        return array
    }
    
    func roll() -> Image {
        let rand = Int.random(in: 1...sides)
        return Image(systemName: "die.face.\(rand).fill")
    }
    
    init(sides: Int) {
        self.sides = sides
    }
    
    //static let example = Dice(id: UUID(), sides: 6)
}
