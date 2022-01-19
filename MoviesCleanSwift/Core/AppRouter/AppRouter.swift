//
//  AppRouter.swift
//  MoviesCleanSwift
//
//  Created by Anton Gutkin on 18.01.2022.
//

import Foundation
import UIKit

struct AppRouter {
    private struct Constants {
        static let moviesListViewControllerTitleText = "themoviedb.org"
    }
    
    private let navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
        showMoviesListScene()
    }
    
    private func showMoviesListScene() {
        let controller = MoviesListViewController.loadFromNib()
        controller.title = Constants.moviesListViewControllerTitleText
        navController.viewControllers = [controller]
    }
}
