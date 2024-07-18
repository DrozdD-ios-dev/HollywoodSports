//
//  CheckDateService.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 18.07.2024.
//

import Foundation

final class CheckDateService {
    
    static func currentMonthYear() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        let result = dateFormatter.string(from: date)
        return result
    }
    
    static func currentDay() -> Date {
        return Date()
    }
    
    static func datesForCurrentWeek() -> [Date] {
        var dates: [Date] = []
        let calendar = Calendar.current
        let currentDate = Date()
        
        let components = calendar.dateComponents([.year, .month, .weekday, .weekdayOrdinal], from: currentDate)
        
        var startOfWeek: Date?
        if let weekday = components.weekday {
            let daysToSubtract = weekday == 1 ? 6 : weekday - 2
            startOfWeek = calendar.date(byAdding: .day, value: -daysToSubtract, to: currentDate)
        }
        
        guard let startDate = startOfWeek else { return dates }
        
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: startDate) {
                dates.append(date)
            }
        }
        return dates
    }
    
    static func comparisonDay(day: String) -> Bool {
        var result = false
        let currentDate = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d-MM-yyyy"
        guard let comparedDay = dateFormatter.date(from: day) else { return false }
        
        let compareDateComponents = calendar.dateComponents([.day, .month], from: comparedDay)
        let currentDateComponents = calendar.dateComponents([.day, .month], from: currentDate)
        if compareDateComponents.day == currentDateComponents.day && compareDateComponents.month == currentDateComponents.month {
            result = true
        } else {
            result = false
        }
        return result
    }
}
