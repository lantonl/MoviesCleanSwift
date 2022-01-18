//
//  UIViewController+MoviesCleanSwift.swift
//  MoviesCleanSwift
//
//  Created by Anton Gutkin on 17.01.2022.
//

import Foundation
import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
