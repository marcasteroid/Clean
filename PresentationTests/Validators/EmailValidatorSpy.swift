//
//  EmailValidatorSpy.swift
//  PresentationTests
//
//  Created by Marco Margarucci on 01/12/23.
//

import Foundation
import Presentation

class EmailValidatorSpy: EmailValidator {
    var isValid = true
    var email: String?
    
    func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }
    
    func simulateInvalidEmail() {
        isValid = false
    }
}
