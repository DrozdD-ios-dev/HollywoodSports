//
//  Day.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 18.07.2024.
//

import Foundation

struct Day: Codable {
    var color: String
    var dayNumber: String
    var character: String
}

extension Day {
    static let mock: [Day] = [
        Day(color: "gray51", dayNumber: "1", character: "M"),
        Day(color: "gray51", dayNumber: "2", character: "T"),
        Day(color: "gray51", dayNumber: "3", character: "W"),
        Day(color: "gray51", dayNumber: "4", character: "T"),
        Day(color: "gray51", dayNumber: "5", character: "F"),
        Day(color: "gray51", dayNumber: "6", character: "S"),
        Day(color: "gray51", dayNumber: "7", character: "S"),
    ]
}
