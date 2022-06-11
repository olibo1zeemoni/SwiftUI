//
//  ModelData.swift
//  Project1
//
//  Created by Olibo moni on 03/04/2022.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
  @Published  var landmarks: [Landmark] = load("landmarkData.json")

}



func load<T: Decodable> (_ fileName: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("Could not find \(fileName) in main bundle")
    }
    
        
    
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(fileName) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(fileName) as \(T.self):\n\(error)")
    }
    
}
