//
//  SignUpViewController.swift
//  UI
//
//  Created by Marco Margarucci on 12/01/24.
//

import Foundation
import UIKit
import Presentation

final class SignUpViewController: UIViewController {

    // Create UI elements
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let signUpButton = UIButton()
    let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the view
        view.backgroundColor = .white
        title = "Sign Up"

        // Configure text fields
        usernameTextField.placeholder = "Username"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true

        // Configure sign-up button
        signUpButton.setTitle("Sign Up", for: .normal)

        // Configure activity indicator
        activityIndicator.hidesWhenStopped = true

        // Add subviews to the view
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        view.addSubview(activityIndicator)

        // Set up constraints (you can customize these based on your layout)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension SignUpViewController: LoadingView {
    func showLoader(viewModel: Presentation.LoadingViewModel) {
        if viewModel.isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
