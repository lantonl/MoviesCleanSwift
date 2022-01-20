//
//  MovieDetailsViewControllerConfiguration.swift
//  MoviesCleanSwift
//
//  Created by Anton Gutkin on 21.01.2022.
//

import Foundation

struct MovieDetailsViewControllerConfiguration {
    private struct Constnats {
        static let releaseDatePlaceholderText = "Relese date:"
        static let ratingPlaceholder = "Rating:"
        static let maximumFractionDigitsForRating = 2
    }
    
    let titleText: String
    let desriptionText: String
    let ratingText: String
    let releaseDateText: String
    
    init(with movie: Movie) {
        self.titleText = movie.title ?? ""
        self.releaseDateText = "\(Constnats.releaseDatePlaceholderText) \(movie.releaseDate ?? "")"
        self.ratingText = "\(Constnats.ratingPlaceholder) \(movie.rating?.string(maximumFractionDigits: Constnats.maximumFractionDigitsForRating) ?? "")"
        self.desriptionText = movie.overview ?? ""
    }
}
