//
//  MovieDetailsInteractorMock.swift
//  MoviesCleanSwiftTests
//
//  Created by Anton Gutkin on 21.01.2022.
//

import Foundation

import Foundation
@testable import MoviesCleanSwift

class MovieDetailsInteractorMock: MovieDetailsBusinessLogic, MovieDetailsDataStore {
    var getMovieDetailsCalled = false
    var presenter: MovieDetailsPresentationLogic?
    var movie: MovieDetails.Response?
    
    func getMovieDetails() {
        getMovieDetailsCalled = true
    }
}
