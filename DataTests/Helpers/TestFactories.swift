//
//  TestFactories.swift
//  DataTests
//
//  Created by Marco Margarucci on 31/08/23.
//

import Foundation

func makeURL() -> URL {
    return URL(string: "http://url.com")!
}

func makeInvalidData() -> Data {
    return Data("invalidData".utf8)
}
