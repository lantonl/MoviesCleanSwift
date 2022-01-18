//
//  BaseNavigationController.swift
//  MoviesCleanSwift
//
//  Created by Anton Gutkin on 17.01.2022.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    private struct Constants {
        static let fontSize = CGFloat(24)
        static let backgroundColor = UIColor.blue
        static let fontColor = UIColor.white
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    private func setup() {
        let font = UIFont.systemFont(ofSize: Constants.fontSize)
        
        let textAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: Constants.fontColor,
            .font: font
        ]
        
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = Constants.backgroundColor
        self.navigationBar.tintColor = Constants.fontColor
        self.navigationBar.titleTextAttributes = textAttributes

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = Constants.backgroundColor
        navBarAppearance.largeTitleTextAttributes = textAttributes
        navBarAppearance.titleTextAttributes = textAttributes

        self.navigationBar.standardAppearance = navBarAppearance
        self.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
