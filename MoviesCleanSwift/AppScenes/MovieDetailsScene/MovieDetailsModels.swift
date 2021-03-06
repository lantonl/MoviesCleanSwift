//
//  MovieDetailsModels.swift
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

enum MovieDetails {
    enum UI {
        struct ViewModel {
            let configuration: MovieDetailsViewControllerConfiguration
        }
    }
    
    struct Response {
        let movie: Movie
    }
}
