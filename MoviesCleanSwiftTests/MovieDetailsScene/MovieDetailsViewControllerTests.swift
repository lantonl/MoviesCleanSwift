//
//  MovieDetailsViewControllerTests.swift
//  MoviesCleanSwiftTests
//
//  Created by Anton Gutkin on 21.01.2022.
//

import XCTest
@testable import MoviesCleanSwift

class MovieDetailsViewControllerTests: XCTestCase {
    private var sut: MovieDetailsViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = MovieDetailsViewController.instantiate(with: MovieDetailsModuleMockFactory.configuratorMock())
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }

    func testSutInitialization() {
        XCTAssertNotNil(sut, "MovieDetailsViewController should be instantiated")
    }
    
    func testSetup() {
        XCTAssertNotNil(sut.router, "MovieDetailsViewController should be instantiated with router")
        XCTAssertNotNil(sut.router?.viewController, "MovieDetailsRouter should be setup with viewController")
        XCTAssertNotNil(sut.router?.dataStore, "MovieDetailsRouter should be setup with dataStore")
        
        XCTAssertNotNil(sut.interactor, "MovieDetailsViewController should be instantiated with iteractor")
        XCTAssertNotNil(sut.interactor?.presenter, "MovieDetailsInteractor should be setup with presenter")
        XCTAssertNotNil(sut.interactor?.presenter, "MovieDetailsInteractor should be setup with presenter")
        
        XCTAssertTrue((sut.interactor as? MovieDetailsInteractorMock)?.getMovieDetailsCalled ?? false, "getMovieDetails() should be called during setup")
    }
}
