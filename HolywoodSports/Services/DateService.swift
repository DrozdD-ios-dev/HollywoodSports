import Foundation

enum DateService {
    
    static func currentMonthYear() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        let result = dateFormatter.string(from: date)
        return result
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
        
        for index in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: index, to: startDate) {
                dates.append(date)
            }
        }
        return dates
    }
}
