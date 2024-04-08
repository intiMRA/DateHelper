import Foundation
enum DateFormats: String {
    case ddMmYyyySpaced = "dd MM yyyy"
    case ddMmYyyyDashed = "dd-MM-yyyy"
    private static let formatter = DateFormatter()
    
    func stringFormat(date: Date) -> String {
        DateFormats.formatter.dateFormat = self.rawValue
        return DateFormats.formatter.string(from: date)
    }
    
    func date(from string: String) -> Date? {
        DateFormats.formatter.dateFormat = self.rawValue
        return DateFormats.formatter.date(from: string)
    }
}

extension Date {
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
    
    func asString(with format: DateFormats) -> String {
        format.stringFormat(date: self)
    }
}

extension String {
    func asDate(with format: DateFormats) -> Date? {
        format.date(from: self)
    }
}

let dateString = "20-11-1996"
let date = dateString.asDate(with: .ddMmYyyyDashed)
let spacedDateString = date?.asString(with: .ddMmYyyySpaced)

date?.addingDays(1)?.asString(with: .ddMmYyyyDashed)
date?.daysFrom(date: "21-11-1996".asDate(with: .ddMmYyyyDashed) ?? .now)
date?.isSameDay(as: "20-11-1996".asDate(with: .ddMmYyyyDashed) ?? .now)

