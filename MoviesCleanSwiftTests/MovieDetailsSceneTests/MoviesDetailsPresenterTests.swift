//
//  MoviesDetailsPresenterTests.swift
//  MoviesCleanSwiftTests
//
//  Created by Anton Gutkin on 21.01.2022.
//

import XCTest
@testable import MoviesCleanSwift

class MoviesDetailsPresenterTests: XCTestCase {
    private var sut: MovieDetailsPresenter!
    private var viewController: MovieDetailsDisplayLogicMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = MovieDetailsPresenter()
        viewController = MovieDetailsDisplayLogicMock()
        sut.viewController = viewController
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
        viewController = nil
    }
    
    func testProperInitialization() {
        XCTAssertNil(viewController.response, "view controller should not contain response after initialization")
    }
    
    func testPresentMovieDetails() {
        let responseMock = MovieDetails.Response(movie: MovieDetailsModuleMockFactory.movieModelMock())
        sut.presentMovieDetails(response: responseMock)
        
        XCTAssertNotNil(viewController.response, "Presenter should pass response to view controller")
    }
}
