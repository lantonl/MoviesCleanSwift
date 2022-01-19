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
    
    func add(childViewController: UIViewController, to placeholder: UIView) {
        childViewController.willMove(toParent: self)
        self.addChild(childViewController)
        
        childViewController.view.frame = placeholder.bounds
        placeholder.addSubview(childViewController.view)
        placeholder.backgroundColor = .clear
        
        childViewController.didMove(toParent: self)
    }
    
    func embed(childViewController: UIViewController, to placeholder: UIView) {
        childViewController.willMove(toParent: self)
        self.addChild(childViewController)
        
        placeholder.addSubviewWithSameSizeConstraints(childViewController.view)
        placeholder.backgroundColor = .clear
        
        childViewController.didMove(toParent: self)
    }
    
    func removeFromParentController() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        self.didMove(toParent: nil)
    }
    
    func hideBackBtnTitle() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    func showPopup(title: String, text: String) {
        let alertController = UIAlertController(title: title,
                                                message: text,
                                                preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
