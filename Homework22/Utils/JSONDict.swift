//
//  JSONDict.swift
//  Homework22
//
//  Created by TMS on 11.12.2021.
//

import Foundation

typealias JSONDict = [String: Any]

protocol JSONable {
    init?(json: JSONDict)
}

protocol JSONEncodable {
    func toDictionary() -> JSONDict
}

extension Array: JSONable where Element: JSONable {
    init?(json: JSONDict) {
        guard let data = json["data"] as? [JSONDict] else { return nil }
        self = data.compactMap { (object) -> Element? in
            return Element(json: object)
        }
    }
}

extension JSONDict {
    func string(key: String) -> String? {
        return self[key] as? String
    }
    
    func stringValue(key: String, defaultValue value: String = "") -> String {
        return string(key: key) ?? value
    }
    
    func date(key: String) -> Date? {
        guard let dateString = string(key: key) else { return nil }
        return DateTimeFormatter.backendDateAndTime.date(from: dateString)
    }
    
    func dateValue(key: String, defaultValue value: Date = Date()) -> Date {
        return date(key: key) ?? value
    }

    func dateNoTime(key: String) -> Date? {
        guard let dateString = string(key: key) else { return nil }
        return DateTimeFormatter.backendDateOnly.date(from: dateString)
    }
    
    func dateNoTimeValue(key: String, defaultValue value: Date = Date()) -> Date {
        return dateNoTime(key: key) ?? value
    }

    func decimal(key: String) -> Decimal? {
        guard let decimalString = string(key: key) else { return nil }
        return Decimal(string: decimalString)
    }
    
    func int(key: String) -> Int? {
        return self[key] as? Int
    }
    
    func intValue(key: String, defaultValue value: Int = 0) -> Int {
        return int(key: key) ?? value
    }
    
    func bool(key: String) -> Bool? {
        return self[key] as? Bool
    }
    
    func boolValue(key: String, defaultValue value: Bool = false) -> Bool {
        return bool(key: key) ?? value
    }

    func decimalValue(key: String, defaultValue value: Decimal = Decimal.zero) -> Decimal {
        return decimal(key: key) ?? value
    }

    func dictionary(key: String) -> JSONDict? {
        return self[key] as? JSONDict
    }
    
    func dictionaryValue(key: String, defaultValue value: JSONDict = [:]) -> JSONDict {
        return dictionary(key: key) ?? value
    }

    func array<T>(key: String) -> [T]? {
        return (self[key] as? [Any])?.compactMap { $0 as? T }
    }

    func arrayValue<T>(key: String) -> [T] {
        return self[key] as? [T] ?? []
    }
}
