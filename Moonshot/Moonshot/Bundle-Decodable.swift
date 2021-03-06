//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Olibo moni on 04/04/2022.
//

import Foundation

extension Bundle {
    func decode<T:Codable>(_ file: String) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else { fatalError("Failed to locate file \(file)")}
        
        guard let data = try? Data(contentsOf: url) else { fatalError("Unable to load file \(file) from bundle")}
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else { fatalError("failed to decode \(file) from bundle")}
        
        return loaded
    }
}
