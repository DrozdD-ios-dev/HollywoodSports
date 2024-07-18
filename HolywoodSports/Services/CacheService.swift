//
//  CacheService.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import Foundation

struct CacheService {
    
    static func saveCache<T: Encodable>(model: T, key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(model) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    static func loadCache<T: Decodable>(key: String) -> T? {
        if let savedData = UserDefaults.standard.value(forKey: key) as? Data {
            let decoder = JSONDecoder()
            let savedUser = try? decoder.decode(T.self, from: savedData)
            return savedUser
        }
        return nil
    }
}
