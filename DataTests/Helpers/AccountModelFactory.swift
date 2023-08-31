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
