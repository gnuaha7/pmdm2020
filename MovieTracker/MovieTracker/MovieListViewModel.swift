//
//  ViewModel.swift
//  MovieTracker
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import UIKit
import Alamofire
import CoreData

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
        let letters = movies.map { String($0.title_.prefix(1)) }
        // Create a Set with all them to eliminate repeated elements.
        let set = Set(letters)
        return Array(set).sorted()
    }

    init() {
        guard let context = AppDelegate.viewContext else { return }
        let request = NSFetchRequest<MovieModel>(entityName: "MovieModel")
        guard let movies = try? context.fetch(request) else { return }
        self.movies = movies

        loadData()
    }

    func loadData() {
        AF.request("https://raw.githubusercontent.com/gnuaha7/pmdm2021/main/Examples/movies.json")
            .responseData { response in
                guard let data = response.data else { return }
                //            self.movies =
                let movieData = (try? JSONDecoder().decode([MovieData].self, from: data)) ?? []
                self.movies = movieData.map { movieData in
                    MovieModel.getOrCreate(with: movieData)
                }

                try? AppDelegate.viewContext?.save()
            }
    }

    private func movies(startingBy letter: String) -> [MovieModel] {
        guard let movies = movies else { return [] }

        return movies
            .filter { $0.title_.hasPrefix(letter) }
            .sorted { $0.title_ < $1.title_ }
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
