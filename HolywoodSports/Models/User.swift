//
//  User.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import Foundation

struct User: Codable {
    var image: URL?
    var gender: Gender
    var weight: Double
    var height: Double
    var points: Int
    var weightType: Weight
    var heightType: Height
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

enum Gender: String, Codable, CaseIterable {
    case female
    case male
}

extension User {
    static let mock: User =
    User(
        image: nil,
        gender: .female,
        weight: 30,
        height: 140,
        points: 0,
        weightType: .kg,
        heightType: .cm,
        showEvent: true,
        currentDay: Date.now
    )
}
