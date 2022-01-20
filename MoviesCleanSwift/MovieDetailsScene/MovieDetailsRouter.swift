//
//  MovieDetailsRouter.swift
//  MoviesCleanSwift
//
//  Created by Anton Gutkin on 20.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MovieDetailsRoutingLogic {}

protocol MovieDetailsDataPassing {
    var dataStore: MovieDetailsDataStore? { get }
}

class MovieDetailsRouter: NSObject, MovieDetailsRoutingLogic, MovieDetailsDataPassing {
    weak var viewController: MovieDetailsViewController?
    var dataStore: MovieDetailsDataStore?
}
