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
    private let loadingView: LoadingView
    private let emailValidator: EmailValidator
    private let addAccount: AddAccount
    
    public init(alertView: AlertView, loadingView: LoadingView, emailValidator: EmailValidator, addAccount: AddAccount) {
        self.alertView = alertView
        self.loadingView = loadingView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        if let message = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: message))
        } else {
            loadingView.showLoader(viewModel: LoadingViewModel(isLoading: true))
            guard let addAccountModel = SignUpMapper.toAddAccoutModel(viewModel: viewModel) else { return }
            addAccount.add(addAccountModel: addAccountModel) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure: self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "Please try again later"))
                case .success: self.alertView.showMessage(viewModel: AlertViewModel(title: "Success", message: "Account added successfully"))
                }
                self.loadingView.showLoader(viewModel: LoadingViewModel(isLoading: false))
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

