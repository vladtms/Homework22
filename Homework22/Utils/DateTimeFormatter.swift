//
//  DateTimeFormatter.swift
//  Homework22
//
//  Created by TMS on 11.12.2021.
//

import Foundation

enum DateTimeFormatter: String {
    case backendDateAndTime = "yyyy-MM-dd'T'HH:mm:ssZ"
    case backendDateOnly = "YYYY-MM-dd"
    case dayMonthShort = "dd MMM"
    
    // MARK: - Public

    func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    func date(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
}

// MARK: - Private

private extension DateTimeFormatter {
    
    var cacheKey: String {
        switch self {
        case .backendDateAndTime: return CacheKey.backendDateAndTime
        case .backendDateOnly: return CacheKey.backendDateOnly
        case .dayMonthShort: return CacheKey.dayMonthShort
        }
    }

    var dateFormatter: DateFormatter {
        guard let cachedFormatter = Thread.current.threadDictionary[cacheKey] as? DateFormatter else {
            let formatter = DateFormatter()
            formatter.dateFormat = rawValue
            switch self {
            case .backendDateAndTime, .backendDateOnly:
                formatter.timeZone = TimeZone(secondsFromGMT: 0)
            default:
                formatter.timeZone = TimeZone.current
            }
            Thread.current.threadDictionary[cacheKey] = formatter
            return formatter
        }
        return cachedFormatter
    }
}

// MARK: - DateFormatter CacheKey

private enum CacheKey {
    static let backendDateAndTime = "dateFormatterCacheKey_backendDateAndTime"
    static let backendDateOnly = "dateFormatterCacheKey_backendDateOnly"
    static let dayMonthShort = "dateFormatterCacheKey_dayMonthShort"
}
