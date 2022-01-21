//
//  MovieDetailsModuleMockFactory.swift
//  MoviesCleanSwiftTests
//
//  Created by Anton Gutkin on 21.01.2022.
//

import Foundation
@testable import MoviesCleanSwift

class MovieDetailsModuleMockFactory {
    static func configuratorMock() -> MovieDetailsModuleConfigurator {
        return MovieDetailsModuleConfigurator(interactor: MovieDetailsInteractorMock(), presenter: MoviewDetailsPresenterMock(), router: MoviewDetailsRouterMock())
    }
    
    static func movieModelMock() -> Movie {
        return Movie(id: 123, posterPath: "posterPath", backdrop: nil, title: "title", releaseDate: "releaseDate", rating: 1.1, overview: "overview")
    }
}
