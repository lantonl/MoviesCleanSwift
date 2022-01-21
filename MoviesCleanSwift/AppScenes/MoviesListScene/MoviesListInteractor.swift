//
//  MoviesListInteractor.swift
//  MoviesCleanSwift
//
//  Created by Anton Gutkin on 18.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MoviesListBusinessLogic {
    func initialRequest()
    func getFirstBatchOfMovies(for request: MoviesList.Movies.Request)
    func getNextBatchOfMovies(for request: MoviesList.Movies.Request)
}

protocol MoviesListDataStore {
    var movies: [Movie] { get set }
}

class MoviesListInteractor: MoviesListDataStore {
    private struct Constants {
        static let firstPageIndex = 1
    }
    
    var presenter: MoviesListPresentationLogic?
    var worker: MoviesListNetworkingWorkerLogic!
    var movies = [Movie]()
    
    private var moviesAPIResponse: MovieAPIResponse?
    
    init(with worker: MoviesListNetworkingWorkerLogic = MoviesListWorker()) {
        self.worker = worker
    }
}

extension MoviesListInteractor: MoviesListBusinessLogic {
    func initialRequest() {
        presenter?.showInitialMessage()
    }
    
    func getFirstBatchOfMovies(for request: MoviesList.Movies.Request) {
        guard !request.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            presenter?.showEmtySearchRequestWarningMessage()
            return
        }
        
        presenter?.showLoadingIndicator()
        
        worker?.getMovies(title: request.title, page: Constants.firstPageIndex) { [weak self] result in
            self?.presenter?.hideLoadingIndicator()
            
            switch result {
            case .success(let response):
                self?.moviesAPIResponse = response
                
                guard let moviesAPIResponse = self?.moviesAPIResponse, !moviesAPIResponse.movies.isEmpty else {
                    self?.presenter?.showEmtySearchRequestWarningMessage()
                    return
                }
                
                self?.movies = moviesAPIResponse.movies
                let moviesListMoviesResponse = MoviesList.Movies.Response(movieAPIResponse: moviesAPIResponse)
                
                self?.presenter?.present(moviesResponse: moviesListMoviesResponse)
            case .failure(let error):
                self?.presenter?.show(error: error)
            }
        }
    }
    
    func getNextBatchOfMovies(for request: MoviesList.Movies.Request) {
        guard let pageToRequest = moviesAPIResponse?.nextPage else {
            return
        }
        
        worker?.getMovies(title: request.title, page: pageToRequest) { [weak self] result in
            switch result {
            case .success(let response):
                self?.moviesAPIResponse = response
                
                guard let moviesAPIResponse = self?.moviesAPIResponse else {
                    return
                }
                
                self?.movies.append(contentsOf: moviesAPIResponse.movies)
                let moviesListMoviesResponse = MoviesList.Movies.Response(movieAPIResponse: moviesAPIResponse)
                self?.presenter?.presentNextPage(moviesResponse: moviesListMoviesResponse)
            case .failure(let error):
                self?.presenter?.show(error: error)
            }
        }
    }
}