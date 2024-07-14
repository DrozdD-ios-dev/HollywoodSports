//
//  UserService.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import Foundation

struct UserService {
    
    static func saveUser(user: User, key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    static func loadUser(key: String) -> User? {
        if let savedData = UserDefaults.standard.value(forKey: key) as? Data {
            let decoder = JSONDecoder()
            let savedUser = try? decoder.decode(User.self, from: savedData)
            return savedUser
        }
        return nil
    }
}
