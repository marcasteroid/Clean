//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Marco Margarucci on 31/08/23.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    return AccountModel(id: "id", name: "name", email: "email", password: "password")
}

func makeAddAccountModel() -> AddAccountModel {
    return AddAccountModel(name: "any_name",
                           email: "any_email@email.com",
                           password: "any_password",
                           passwordConfirmation: "any_password")
}
