//
//  MovieCellViewModel.swift
//  MovieTracker
//
//  Created by Ariel Hernández Amador on 4/3/21.
//

import Foundation

class MovieCellViewModel {

    private let movie: MovieModel

    init(for movie:MovieModel) {
        self.movie = movie
    }

    var title: String {
        movie.title_
    }

    var subtitleLabel: String {
        "(\(movie.year)) • \(movie.runtime_)"
    }

    var rating: String {
        "\(movie.metascore)"
    }

    var imageURL: URL? {
        return movie.poster
    }
}
