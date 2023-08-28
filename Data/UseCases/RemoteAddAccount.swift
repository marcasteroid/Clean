//
//  RemoteAddAccount.swift
//  Data
//
//  Created by Marco Margarucci on 27/08/23.
//

import Foundation
import Domain

public final class RemoteAddAccount: AddAccount {
    private var url: URL
    private var httpClient: HttpPostClient
    
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        httpClient.post(to: url, with: addAccountModel.toData()) { error in
            completion(.failure(.unexpected))
        }
    }
}
