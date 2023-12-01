//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Marco Margarucci on 24/10/23.
//

import Foundation
import Domain

public final class SignUpPresenter {
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    private let addAccount: AddAccount
    
    public init(alertView: AlertView, emailValidator: EmailValidator, addAccount: AddAccount) {
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        if let message = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: message))
        } else {
            guard   let name = viewModel.name,
                    let email = viewModel.email,
                    let password = viewModel.password,
                    let passwordConfirmation = viewModel.passwordConfirmation
            else { return }
            let addAccountModel = AddAccountModel(name: name,
                                               email: email,
                                               password: password,
                                               passwordConfirmation: passwordConfirmation)
            addAccount.add(addAccountModel: addAccountModel) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure: self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "Please try again later"))
                case .success: break
                }
            }
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
            return "Invalid password confirmation"
        }
        if let email = viewModel.email {
            if !emailValidator.isValid(email: email) {
                return "Invalid email"
            }
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
