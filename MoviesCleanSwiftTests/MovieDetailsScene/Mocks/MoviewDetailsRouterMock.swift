//
//  MoviewDetailsRouterMock.swift
//  MoviesCleanSwiftTests
//
//  Created by Anton Gutkin on 21.01.2022.
//

import Foundation
@testable import MoviesCleanSwift

class MoviewDetailsRouterMock: NSObject, MovieDetailsDataPassing, MovieDetailsRoutingLogic {
    var viewController: MovieDetailsViewController?
    var dataStore: MovieDetailsDataStore?
}
