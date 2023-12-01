//
//  LoadingViewSpy.swift
//  PresentationTests
//
//  Created by Marco Margarucci on 01/12/23.
//

import Foundation
import Presentation

class LoadingViewSpy: LoadingView {
    var emit: ((LoadingViewModel) -> Void)?
    
    func observe(completion: @escaping (LoadingViewModel) -> Void) {
        self.emit = completion
    }
    
    func showLoader(viewModel: LoadingViewModel) {
        self.emit?(viewModel)
    }
}
