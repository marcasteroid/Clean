//
//  Extensions+Helpers.swift
//  Data
//
//  Created by Marco Margarucci on 28/08/23.
//

import Foundation

public extension Data {
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
    
    func toJSON() -> [String: Any]? {
        return try? JSONSerialization.jsonObject(with: self, options: .fragmentsAllowed) as? [String: Any]
    }
}
