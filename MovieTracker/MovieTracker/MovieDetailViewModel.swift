//
//  MovieDetailViewModel.swift
//  MovieTracker
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import Foundation

protocol MovieDetailViewModelDelegate {
    func didChangedTrackedState(viewModel: MovieDetailViewModel);
    func didChangedLovedState(viewModel: MovieDetailViewModel);
}

class MovieDetailViewModel {
    private let movie: MovieModel
    var delegate: MovieDetailViewModelDelegate?

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

    var imdbRating: String {
        movie.imdbRating
    }

    var imageURL: URL? {
        URL(string: movie.Poster)
    }

    var loved = false
    var tracked = false

    func toggleTracked() {
        tracked.toggle()
        delegate?.didChangedTrackedState(viewModel: self)
    }

    func toggleLoved() {
        loved.toggle()
        delegate?.didChangedLovedState(viewModel: self)
    }
}
