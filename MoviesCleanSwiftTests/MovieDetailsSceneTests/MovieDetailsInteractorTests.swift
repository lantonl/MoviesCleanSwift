//
//  MovieDetailsInteractorTests.swift
//  MoviesCleanSwiftTests
//
//  Created by Anton Gutkin on 21.01.2022.
//


import XCTest
@testable import MoviesCleanSwift

class MovieDetailsInteractorTests: XCTestCase {
    private var sut: MovieDetailsInteractor!
    private var presenter: MoviewDetailsPresenterMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = MovieDetailsInteractor()
        presenter = MoviewDetailsPresenterMock()
        sut.presenter = presenter
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
        presenter = nil
    }
    
    func testProperInitialization() {
        XCTAssertFalse(presenter.presentMovieDetailsCalled, "presentMovieDetails() should not be called")
    }
    
    func testPresentMovieDetailsWithouDataStoreInitialization() {
        sut.getMovieDetails()
        
        XCTAssertFalse(presenter.presentMovieDetailsCalled, "PresentMovieDetails should not be called if data store is empty")
    }
    
    func testPresentMovieDetailsWithInitializedDataStore() {
        sut.movie = MovieDetails.Response(movie: MovieDetailsModuleMockFactory.movieModelMock())  
        sut.getMovieDetails()
        
        XCTAssertTrue(presenter.presentMovieDetailsCalled, "PresentMovieDetails should be called if data store is not empty")
    }
}
