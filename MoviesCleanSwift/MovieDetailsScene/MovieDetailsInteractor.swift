//
//  MovieDetailsInteractor.swift
//  MoviesCleanSwift
//
//  Created by Anton Gutkin on 20.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MovieDetailsBusinessLogic {
    func getMovieDetails()
}

protocol MovieDetailsDataStore {
    var movie: MovieDetails.Response? { get set }
}

class MovieDetailsInteractor: MovieDetailsDataStore {
    var movie: MovieDetails.Response?
    var presenter: MovieDetailsPresentationLogic?
    var worker: MovieDetailsNetworkingWorkerLogic?

    required init(worker: MovieDetailsNetworkingWorkerLogic = MovieDetailsWorker()) {
        self.worker = worker
    }
}

extension MovieDetailsInteractor: MovieDetailsBusinessLogic {
    func getMovieDetails() {
        guard let movieResponse = movie else {
            return
        }
        
        presenter?.presentMovieDetails(response: movieResponse)
    }
}
