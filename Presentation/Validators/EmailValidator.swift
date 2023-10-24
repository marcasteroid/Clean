//
//  EmailValidator.swift
//  Presentation
//
//  Created by Marco Margarucci on 24/10/23.
//

import Foundation

public protocol EmailValidator {
    func isValid(email: String) -> Bool
}
