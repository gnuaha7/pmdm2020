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
        movie.title_
    }

    var plot: String {
        movie.plot_
    }

    var extraData: String {
        movie.rated?.name ?? "Not Rated"
    }

    var actors: String {
        movie.actors_.map { $0.name_ }.joined(separator: ", ")

    }

    var year: String {
        "(\(movie.year))"
    }

    var runningTime: String {
        movie.runtime_
    }

    var imdbRating: String {
        "\(movie.imdbRating)"
    }

    var imageURL: URL? {
        movie.poster
    }

    var loved: Bool {
        get {
            movie.loved
        }
        set {
            movie.loved = newValue
        }
    }

    var tracked: Bool {
        get {
            movie.tracked
        }
        set {
            movie.tracked = newValue
        }
    }

    func toggleTracked() {
        tracked.toggle()
        delegate?.didChangedTrackedState(viewModel: self)
    }

    func toggleLoved() {
        loved.toggle()
        delegate?.didChangedLovedState(viewModel: self)
    }
}
