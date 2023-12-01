//
//  SignUpMapper.swift
//  Presentation
//
//  Created by Marco Margarucci on 01/12/23.
//

import Foundation
import Domain

public final class SignUpMapper {
    
    static func toAddAccoutModel(viewModel: SignUpViewModel) -> AddAccountModel? {
        guard let name = viewModel.name,
              let email = viewModel.email,
              let password = viewModel.password,
              let passwordConfirmation = viewModel.passwordConfirmation
        else { return nil }
        return AddAccountModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
}
