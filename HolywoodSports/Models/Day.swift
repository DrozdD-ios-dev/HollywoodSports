//
//  Day.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 18.07.2024.
//

import Foundation

struct Day {
    var color: String
    var number: Int
    var character: String
}

extension Day {
    static let mock: [Day] = [
        Day(color: "purple-dark", number: 1, character: "M"),
        Day(color: "gray51", number: 2, character: "T"),
        Day(color: "purple-dark", number: 3, character: "W"),
        Day(color: "gray51", number: 4, character: "T"),
        Day(color: "gray51", number: 5, character: "F"),
        Day(color: "gray51", number: 6, character: "S"),
        Day(color: "gray51", number: 7, character: "S"),
    ]
}
