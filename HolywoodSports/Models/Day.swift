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
    var opacity: Double
}

extension Day {
    static let mock: [Day] = [
        Day(color: "gray-51", dayNumber: "1", character: "M", opacity: 0.5),
        Day(color: "gray-51", dayNumber: "2", character: "T", opacity: 0.5),
        Day(color: "gray-51", dayNumber: "3", character: "W", opacity: 0.5),
        Day(color: "gray-51", dayNumber: "4", character: "T", opacity: 0.5),
        Day(color: "gray-51", dayNumber: "5", character: "F", opacity: 0.5),
        Day(color: "gray-51", dayNumber: "6", character: "S", opacity: 0.5),
        Day(color: "gray-51", dayNumber: "7", character: "S", opacity: 0.5)
    ]
}
