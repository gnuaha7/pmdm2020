//
//  MovieDetailViewModel.swift
//  MovieTracker
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import Foundation

class MovieDetailViewModel {
    private let movie: MovieModel

    init(for movie:MovieModel) {
        self.movie = movie
    }

    var title: String {
        movie.Title
    }

    var plot: String {
        movie.Plot
    }

    var extraData: String {
        "Actors: \(movie.Actors)"
    }

    var year: String {
        "(\(movie.Year))"
    }

    var runningTime: String {
        movie.Runtime
    }

    var rating: String {
        "Meta: \(movie.Metascore) • IMDB: \(movie.imdbRating)"
    }

    var imageURL: URL? {
        URL(string: movie.Poster)
    }
}
