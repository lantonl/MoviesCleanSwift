//
//  BaseViewController.swift
//  MoviesCleanSwift
//
//  Created by Anton Gutkin on 17.01.2022.
//

import Foundation
import UIKit

protocol BaseViewControllerProtocol: AnyObject {
    var loadingController: LoadingViewController? { get set }
    
    func show(error: NetworkResponseError)
    func show(message: String, title: String?)
    
    func showLoadingController(aboveNavBar: Bool)
    func hideLoadingController()
    func set(title: String)
}

class BaseViewController: UIViewController {
    var loadingController: LoadingViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

extension BaseViewController: BaseViewControllerProtocol {
    func set(title: String) {
        self.title = title
    }
    
    func show(error: NetworkResponseError) {
        self.show(message: error.description(), title: "Error")
    }
    
    func show(message: String, title: String?) {
        let popup = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let positiveAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        popup.addAction(positiveAction)
        popup.preferredAction = positiveAction
        
        self.present(popup, animated: true, completion: nil)
    }
    
    func showLoadingController(aboveNavBar: Bool) {
        showLoadingController(on: self, view: self.view)
    }
    
    func showLoadingController(on controller: UIViewController, view: UIView) {
        loadingController = LoadingViewController()
        controller.add(childViewController: loadingController!, to: view)
    }
    
    func hideLoadingController() {
        loadingController?.removeFromParentController()
        loadingController = nil
    }
}
