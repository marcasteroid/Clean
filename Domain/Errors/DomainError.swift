//
//  DomainError.swift
//  Domain
//
//  Created by Marco Margarucci on 28/08/23.
//

import Foundation

public enum DomainError: Error {
    case unexpected
    case emailInUse
    case expiredSession
}
