//
//  MoviewDetailsPresenterMock.swift
//  MoviesCleanSwiftTests
//
//  Created by Anton Gutkin on 21.01.2022.
//

import Foundation
@testable import MoviesCleanSwift

class MoviewDetailsPresenterMock: MovieDetailsPresentationLogic {
    var presentMovieDetailsCalled = false
    var viewController: MovieDetailsDisplayLogic?
    
    func presentMovieDetails(response: MovieDetails.Response) {
        presentMovieDetailsCalled = true
    }
}
