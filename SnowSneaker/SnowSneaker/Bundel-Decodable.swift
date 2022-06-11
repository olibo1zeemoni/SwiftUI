//
//  Bundel-Decodable.swift
//  SnowSneaker
//
//  Created by Olibo moni on 05/06/2022.
//

import Foundation

extension Bundle {
    func decode<T:Decodable>(_ file: String)-> T {
        guard let url = self.url(forResource: file, withExtension: nil) else { fatalError("Failed to locate \(file) in Bundle") }
        guard let data = try? Data(contentsOf: url) else { fatalError("Failed to load \(file) from Bundle") }
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(T.self, from: data) else { fatalError("Failed to decode \(file) from Bundle")}
        return loaded
    }
    
}
