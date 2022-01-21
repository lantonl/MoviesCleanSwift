//
//  MovieDetailsDisplayLogicMock.swift
//  MoviesCleanSwiftTests
//
//  Created by Anton Gutkin on 21.01.2022.
//

import Foundation
@testable import MoviesCleanSwift

class MovieDetailsDisplayLogicMock: MovieDetailsDisplayLogic {
    var response: MovieDetails.UI.ViewModel?
    
    func displayMovieDetails(viewModel: MovieDetails.UI.ViewModel) {
        self.response = viewModel
    }
}
