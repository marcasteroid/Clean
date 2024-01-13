//
//  Instantiable.swift
//  UI
//
//  Created by Marco Margarucci on 13/01/24.
//

import Foundation
import UIKit

public protocol Instantiable {
    static func instantiate() -> Self
}

extension Instantiable where Self: UIViewController {
    public static func instantiate() -> Self {
        let vcName = String(describing: self)
        let sbName = vcName.components(separatedBy: "ViewController")[0]
        let bundle = Bundle(for: Self.self)
        let sb = UIStoryboard(name: sbName, bundle: bundle)
        return sb.instantiateViewController(identifier: vcName) as! Self
    }
}
