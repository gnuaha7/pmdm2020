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
        movie.Title
    }

    var subtitleLabel: String {
        "(\(movie.Year)) • \(movie.Runtime)"
    }

    var rating: String {
        movie.Metascore
    }

    var imageURL: URL? {
        URL(string: movie.Poster)
    }
}
