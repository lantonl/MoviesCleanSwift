//
//  LoadingViewController.swift
//  MoviesCleanSwift
//
//  Created by Anton Gutkin on 17.01.2022.
//

import Foundation
import UIKit

class LoadingViewController: BaseViewController {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.color = .blue
        activityIndicator.startAnimating()
    }
}
