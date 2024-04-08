import Foundation

extension Date {
    enum DateFormats: String {
        case ddMmYyyySpaced = "dd mm yyyy"
        case ddMmYyyyDashed = "dd-mm-yyyy"
        private static let formatter = DateFormatter()
        
        static func format(date: Date, with format: DateFormats) -> String {
            formatter.dateFormat = format.rawValue
            return formatter.string(from: date)
        }
        
        static func date(from string: String, with format: DateFormats) -> Date? {
            formatter.dateFormat = format.rawValue
            return formatter.date(from: string)
        }
    }
    
    func addingDays(_ days: Int, calendar: Calendar = .current) -> Date? {
       calendar.date(byAdding: .day, value: days, to: self)
    }
    
    func isSameDay(as date: Date, calendar: Calendar = .current) -> Bool {
        return calendar.isDate(self, equalTo: date, toGranularity: .day)
    }
    
    func daysFrom(date: Date, calendar: Calendar = .current) -> Int? {
        if let days = calendar.dateComponents([.day], from: self, to: date).day {
            return days
        }
        return nil
    }
    
    static func date(from string: String, with format: DateFormats) -> Date? {
        DateFormats.date(from: string, with: format)
    }
    
    static func dateString(from date: Date, with format: DateFormats) -> String {
        DateFormats.format(date: date, with: format)
    }
}
