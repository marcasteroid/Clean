//
//  TestFactories.swift
//  PresentationTests
//
//  Created by Marco Margarucci on 01/12/23.
//

import Foundation
import Presentation

func makeSignUpViewModel(name: String? = "any_name",
                         email: String? = "any_email@email.com",
                         password: String? = "any_password",
                         passwordConfirmation: String? = "any_password") -> SignUpViewModel {
    return SignUpViewModel(name:name,
                           email: email,
                           password: password,
                           passwordConfirmation: passwordConfirmation)
}

func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
    return AlertViewModel(title: "Error", message: "Field \(fieldName) cannot be empty")
}

func makeInvalidAlertViewModel(fieldName: String) -> AlertViewModel {
    return AlertViewModel(title: "Error", message: "Invalid \(fieldName)")
}

func makeErrorAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(title: "Error", message: message)
}

func makeSuccessAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(title: "Success", message: message)
}
