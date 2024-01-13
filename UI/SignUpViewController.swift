//
//  SignUpViewController.swift
//  UI
//
//  Created by Marco Margarucci on 12/01/24.
//

import Foundation
import UIKit
import Presentation

public final class SignUpViewController: UIViewController {

    public weak var nameTextField: UITextField? = {
        let textField = UITextField()
        return textField
    }()
    
    public weak var emailTextField: UITextField? = {
        let textField = UITextField()
        return textField
    }()
    
    public weak var passwordTextField: UITextField? = {
        let textField = UITextField()
        return textField
    }()
    
    public weak var passwordConfirmationTextField: UITextField? = {
        let textField = UITextField()
        return textField
    }()
    
    public weak var signUpButton: UIButton? = {
        let button = UIButton()
        return button
    }()
    
    public weak var activityIndicator: UIActivityIndicatorView? = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    var signUp: ((SignUpRequest) -> Void)?

    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "Clean"
        signUpButton?.layer.cornerRadius = 8
        signUpButton?.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        activityIndicator?.color = .white
        hideKeyboardOnTap()
    }
    
    @objc private func signUpButtonTapped() {
        let viewModel = SignUpRequest(name: nameTextField?.text, email: emailTextField?.text, password: passwordTextField?.text, passwordConfirmation: passwordConfirmationTextField?.text)
        signUp?(viewModel)
    }
}

extension SignUpViewController: LoadingView {
    public func showLoader(viewModel: Presentation.LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            activityIndicator?.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            activityIndicator?.stopAnimating()
        }
    }
}

extension SignUpViewController: AlertView {
    public func showMessage(viewModel: Presentation.AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
