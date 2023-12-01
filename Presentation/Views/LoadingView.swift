//
//  LoadingView.swift
//  Presentation
//
//  Created by Marco Margarucci on 01/12/23.
//

import Foundation

public protocol LoadingView {
    func showLoader(viewModel: LoadingViewModel)
}

public struct LoadingViewModel: Equatable {
    public var isLoading: Bool
    
    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }
}
