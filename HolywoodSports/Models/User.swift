//
//  User.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import Foundation

struct User {
    let gender: Gender
    let weight: Double
    let height: Double
    let points: Int
    let weightValue: Weight
    let heightValue: Height
}

enum Weight {
    case kg
    case lbs
}

enum Height {
    case cm
    case ft
}

extension User {
    static let mock = User(
        gender: .male,
        weight: 80.2,
        height: 175,
        points: 0,
        weightValue: .kg,
        heightValue: .ft
    )
}
