//
//  DateUtils.swift
//  TestStan
//
//  Created by Nikita on 06.12.2023.
//

import Foundation

class DateUtils {
    
    class func timestampToDate(_ time: Int64) -> Date {
        let timestamp: Double = Double(time / 1000)
        return Date(timeIntervalSince1970: timestamp)
    }
    
    class func stringToDate(_ str: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.date(from: str) ?? Date()
    }
    
    class func formatDate(_ date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        return dateFormatter.date(from: date) ?? Date()
    }

    class func formatDateMMMd(_ date: Date) -> String {
        return formatDate(date, format: "MMM d")
    }
    
    class func formatDateMMMdyyyy(_ date: Date) -> String {
        return formatDate(date, format: "MMM d, yyyy")
    }
    
    class private func formatDate(_ date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
}
