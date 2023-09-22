//
//  HttpError.swift
//  Data
//
//  Created by Marco Margarucci on 28/08/23.
//

import Foundation

public enum HttpError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}
