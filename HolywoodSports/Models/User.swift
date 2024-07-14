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
}

enum Weight: Codable {
    case kg
    case lbs
}

enum Height: Codable {
    case cm
    case ft
}

extension User {
    static let mock = User(
        image: "",
        gender: .female,
        weight: 60.0,
        height: 160,
        points: 25,
        weightValue: .kg,
        heightValue: .cm
    )
}
