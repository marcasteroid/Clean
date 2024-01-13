//
//  SignUpRequest.swift
//  Presentation
//
//  Created by Marco Margarucci on 13/01/24.
//

import Foundation
import Domain

public struct SignUpRequest: Model {
    public var name: String?
    public var email: String?
    public var password: String?
    public var passwordConfirmation: String?
    
    public init(name: String? = nil, email: String? = nil, password: String? = nil, passwordConfirmation: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
    
    public func toAddAccountModel() -> AddAccountModel? {
        if let name = name, let email = email, let password = password, let passwordConfirmation = passwordConfirmation {
            return AddAccountModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
        }
        return nil
    }
}
