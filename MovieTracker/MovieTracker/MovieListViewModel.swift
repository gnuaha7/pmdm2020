//
//  ViewModel.swift
//  MovieTracker
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import Foundation
import Alamofire

protocol MovieListViewModelDelegate {
    func didUpdateMovies(viewModel: MovieListViewModel);
}

class MovieListViewModel {
    var delegate: MovieListViewModelDelegate?

    var movies: [MovieModel]? {
        didSet {
            delegate?.didUpdateMovies(viewModel: self)
        }
    }

    var sectionIndexes: [String] {
        guard let movies = movies else { return [] }

        // Extract all first letters.
        let letters = movies.map { String($0.Title.prefix(1)) }
        // Create a Set with all them to eliminate repeated elements.
        let set = Set(letters)
        return Array(set).sorted()
    }

    init() {
        loadData()
    }

    func loadData() {
        AF.request("https://raw.githubusercontent.com/gnuaha7/pmdm2021/main/Examples/movies.json")
            .responseData { response in
            guard let data = response.data else { return }
            self.movies = try? JSONDecoder().decode([MovieModel].self, from: data)
        }
    }

    private func movies(startingBy letter: String) -> [MovieModel] {
        guard let movies = movies else { return [] }

        return movies
            .filter { $0.Title.hasPrefix(letter) }
            .sorted { $0.Title < $1.Title }
    }

    func movie(at indexPath:IndexPath) -> MovieModel {
        let letter = sectionIndexes[indexPath.section]
        let sectionMovies = movies(startingBy: letter)
        return sectionMovies[indexPath.row]
    }

    func numberOfMovies(startingBy letter: String) -> Int {
        return movies(startingBy: letter).count
    }

    func movieCellViewModel(forMovieAt indexPath:IndexPath) -> MovieCellViewModel {
        MovieCellViewModel(for: movie(at:indexPath))
    }

    func movieDetailViewModel(forMovieAt indexPath:IndexPath) -> MovieDetailViewModel {
        MovieDetailViewModel(for: movie(at:indexPath))
    }
}
