//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Marco Margarucci on 24/10/23.
//

import Foundation

public final class SignUpPresenter {
    private let alertView: AlertView
    
    public init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        if let message = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: message))
        }
    }
    
    private func validate(viewModel: SignUpViewModel) -> String? {
        if viewModel.name == nil || viewModel.name!.isEmpty {
            return "Field name cannot be empty"
        } else if viewModel.email == nil || viewModel.email!.isEmpty {
            return "Field email cannot be empty"
        } else if viewModel.password == nil || viewModel.password!.isEmpty {
            return "Field password cannot be empty"
        } else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation!.isEmpty {
            return "Field password confirmation cannot be empty"
        } else if viewModel.password != viewModel.passwordConfirmation {
            return "Password and password confirmation must be equal"
        }
        return nil
    }
}

public struct SignUpViewModel {
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
}
