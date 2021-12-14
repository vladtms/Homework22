//
//  KeyedDecodingContainer+Values.swift
//  UpstoxProBeta
//
//  Created by Serhii Petrishenko on 10.07.2020.
//  Copyright © 2020 Upstox. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {
    
  func boolValue(for key: KeyedDecodingContainer<K>.Key) -> Bool {
    return (try? self.decode(Bool.self, forKey: key)) ?? false
  }
  
  func bool(for key: KeyedDecodingContainer<K>.Key) -> Bool? {
    return try? self.decode(Bool.self, forKey: key)
  }
  
  func intValue(for key: KeyedDecodingContainer<K>.Key) -> Int {
    return (try? self.decode(Int.self, forKey: key)) ?? 0
  }
  
  func int(for key: KeyedDecodingContainer<K>.Key) -> Int? {
    return try? self.decode(Int.self, forKey: key)
  }
  
  func doubleValue(for key: KeyedDecodingContainer<K>.Key) -> Double {
      return (try? self.decode(Double.self, forKey: key)) ?? 0.0
  }
  
  func double(for key: KeyedDecodingContainer<K>.Key) -> Double? {
    return try? self.decode(Double.self, forKey: key)
  }
  
  func stringValue(for key: KeyedDecodingContainer<K>.Key) -> String {
    return (try? self.decode(String.self, forKey: key)) ?? ""
  }
  
  func string(for key: KeyedDecodingContainer<K>.Key) -> String? {
    return try? self.decode(String.self, forKey: key)
  }
  
  func arrayValue<T: Decodable>(for key: KeyedDecodingContainer<K>.Key) -> [T] {
    return (try? self.decode([T].self, forKey: key)) ?? []
  }
  
  func array<T: Decodable>(for key: KeyedDecodingContainer<K>.Key) -> [T]? {
    return try? self.decode([T].self, forKey: key)
  }
  
  func dictionaryValue<T: Decodable>(for key: KeyedDecodingContainer<K>.Key) -> [String: T] {
    return (try? self.decode([String: T].self, forKey: key)) ?? [:]
  }
  
  func dictionary<T: Decodable>(for key: KeyedDecodingContainer<K>.Key) -> [String: T]? {
    return try? self.decode([String: T].self, forKey: key)
  }
  
  func objectValue<T: Decodable>(for key: KeyedDecodingContainer<K>.Key) throws -> T {
    return try self.decode(T.self, forKey: key)
  }
  
  func object<T: Decodable>(for key: KeyedDecodingContainer<K>.Key) -> T? {
    return try? self.decode(T.self, forKey: key)
  }
    
}

// MARK: - Exception cases

extension KeyedDecodingContainer {
  
  func decodeIntIfString(for key: KeyedDecodingContainer<K>.Key) -> Int? {
    if let value = try? decode(Int.self, forKey: key) {
      return value
    }
    guard let strValue = try? decode(String.self, forKey: key) else {
      return nil
    }
    return Int(strValue)
  }
  
  func decodeDoubleIfString(for key: KeyedDecodingContainer<K>.Key) -> Double? {
    if let value = try? decode(Double.self, forKey: key) {
      return value
    }
    guard let strValue = try? decode(String.self, forKey: key) else {
      return nil
    }
    return Double(strValue)
  }
  
}
