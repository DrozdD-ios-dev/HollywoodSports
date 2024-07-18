//
//  User.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import Foundation

struct User: Codable {
    var image: String
    var gender: Gender
    var weight: Double
    var height: Double
    var points: Int
    var weightValue: Weight
    var heightValue: Height
    var showEvent: Bool
    var currentDay: Date
}

enum Weight: String, Codable, CaseIterable {
    case kg
    case lbs
}

enum Height: String, Codable, CaseIterable {
    case cm
    case ft
}

extension User {
    static let mock: User = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let currentDay = dateFormatter.date(from: "01.01.2024") ?? Date()
        
        return User(
            image: "",
            gender: .female,
            weight: 60.0,
            height: 160,
            points: 0,
            weightValue: .kg,
            heightValue: .cm,
            showEvent: true,
            currentDay: currentDay)
    }()
}
