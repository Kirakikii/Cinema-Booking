//
//  Film.swift
//  cinema_booking
//
//  Created by 吴泓昕 on 5/13/24.
//

import Foundation

struct Film: Identifiable, Decodable {
    var id: String { filmName }
    let filmName: String
    let duration: String
    let imageName: String
    let description: String
}

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil),
              let data = try? Data(contentsOf: url),
              let loaded = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        return loaded
    }
}
