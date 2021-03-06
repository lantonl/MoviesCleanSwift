//
//  MoviesListPresenter.swift
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

protocol MoviesListPresentationLogic {
    var viewController: MoviesListDisplayLogic? { get set }
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func show(error: Error?)
    func showEmtySearchRequestWarningMessage()
    func showEmptySearchResultMessage()
    func showInitialMessage()
    func present(moviesResponse: MoviesList.Movies.Response)
    func presentNextPage(moviesResponse: MoviesList.Movies.Response)
}

class MoviesListPresenter {
    weak var viewController: MoviesListDisplayLogic?
    var movieTableviewCellConfigurations = [MoviesList.UI.CellConfiguration]()
}


extension MoviesListPresenter: MoviesListPresentationLogic {
    private struct Constants {
        static let defaultWarningMessageTitle = "Something went wrong"
        static let emtySearchRequestWarningMessageDescription = "We can not search films without name. Please type something"
        static let emptySearchResultWarningMessageDescription = "We could not find any movies =("
        
        static let initialMessageTitle = "Hello!"
        static let initialMessageDescription = "We can find any film you search. Just type something in search field! =)"
    }
    
    func showInitialMessage() {
        let message = MoviesList.UI.Message(title: Constants.initialMessageTitle, description: Constants.initialMessageDescription)
        viewController?.display(message: message)
    }
    func showEmtySearchRequestWarningMessage() {
        let message = MoviesList.UI.Message(title: Constants.defaultWarningMessageTitle, description: Constants.emtySearchRequestWarningMessageDescription)
        viewController?.display(message: message)
    }
    
    func showEmptySearchResultMessage() {
        let message = MoviesList.UI.Message(title: Constants.defaultWarningMessageTitle, description: Constants.emptySearchResultWarningMessageDescription)
        viewController?.display(message: message)
    }
    
    func showLoadingIndicator() {
        viewController?.displayLoadingindicator()
    }
    
    func hideLoadingIndicator() {
        viewController?.hideLoadingindicator()
    }
    
    func show(error: Error?) {
        guard let error = error as? NetworkResponseError else {
            return
        }
        
        viewController?.display(error: error)
    }
    
    func present(moviesResponse: MoviesList.Movies.Response) {
        var newMovieTableviewCellConfigurations = generateCellCongigurations(with: moviesResponse.movieAPIResponse.movies)
        
        if moviesResponse.movieAPIResponse.nextPage != nil {
            let loadingCellConfiguration = (MoviesList.UI.CellType.loading, LoadingTableViewCellConfiguration())
            newMovieTableviewCellConfigurations.append(loadingCellConfiguration)
        }
        
        let moviesListViewModel = MoviesList.UI.ViewModel(cellConfigurations: newMovieTableviewCellConfigurations)
        
        viewController?.displayMovies(viewModel: moviesListViewModel)
        
        movieTableviewCellConfigurations = newMovieTableviewCellConfigurations
    }
    
    func presentNextPage(moviesResponse: MoviesList.Movies.Response) {
        if let loadingCellIndex = movieTableviewCellConfigurations.firstIndex(where: { $0.cellType == .loading }) {
            movieTableviewCellConfigurations.remove(at: loadingCellIndex)
        }
        
        var newMovieTableviewCellConfigurations = movieTableviewCellConfigurations + generateCellCongigurations(with: moviesResponse.movieAPIResponse.movies)
        
        if moviesResponse.movieAPIResponse.nextPage != nil {
            let loadingCellConfiguration = (MoviesList.UI.CellType.loading, LoadingTableViewCellConfiguration())
            newMovieTableviewCellConfigurations.append(loadingCellConfiguration)
        }
        
        let moviesListViewModel = MoviesList.UI.ViewModel(cellConfigurations: newMovieTableviewCellConfigurations)
        
        viewController?.displayMovies(viewModel: moviesListViewModel)
        
        movieTableviewCellConfigurations = newMovieTableviewCellConfigurations
    }
    
    private func generateCellCongigurations(with movies: [Movie]) -> [MoviesList.UI.CellConfiguration] {
        var newMovieTableviewCellConfigurations = [MoviesList.UI.CellConfiguration]()
        
        for movie in movies {
            let movieTableviewCellConfiguration = MovieTableViewCellConfiguration(title: movie.title, releaseDate: movie.releaseDate, rate: movie.rating)
            let cellConfiguration = (MoviesList.UI.CellType.movie, movieTableviewCellConfiguration)
            newMovieTableviewCellConfigurations.append(cellConfiguration)
        }
        
        return newMovieTableviewCellConfigurations
    }
}
