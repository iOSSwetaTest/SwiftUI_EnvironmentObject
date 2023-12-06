//
//  JSONDecoder+Ext.swift
//  AccountsDemo
//
//  Created by SD on 27/03/23.
//

import Foundation

extension KeyedDecodingContainer {
    
    func decodeArray<T: Codable>(_ type: T.Type, forKey key: Key) -> [T] {
        if let array = try? self.decode([T].self, forKey: key) {
            return array
        } else {
            return []
        }
    }
    
    func decode<T: Decodable>(forKey key: Key, defaultValue: T) -> T {
        return (try? self.decode(T.self, forKey: key)) ?? defaultValue
    }
    
}

extension String {
    var digitOnly: String {
        self.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)
    }
}

struct Amount: Codable {
    let formatted: String
    let doubleValue: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        var amount: Double?
        if let stringValue = try? container.decode(String.self) {
            amount = Double(stringValue.digitOnly)
        } else if let intValue = try? container.decode(Int.self) {
            amount = Double(intValue)
        } else {
            amount = try? container.decode(Double.self)
        }
        if let amount {
            formatted = amount.toCurrencyString()
            doubleValue = amount
        } else {
            throw DecodingError.typeMismatch(Amount.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Invalid amount format"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.doubleValue)
    }
  
}
