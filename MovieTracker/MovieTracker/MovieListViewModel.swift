//
//  ViewModel.swift
//  MovieTracker
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import Foundation

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

    func movies(startingBy letter: String) -> [MovieModel] {
        guard let movies = movies else { return [] }

        let tmp = movies
            .filter { $0.Title.hasPrefix(letter) }
        let tmp2 = tmp
            .sorted { $0.Title < $1.Title }
        return tmp2
    }

    init() {
        loadData()
    }

    func loadData() {
        let session = URLSession(configuration: .default)
        guard let url = URL(string: "https://raw.githubusercontent.com/gnuaha7/pmdm2021/main/Examples/movies.json") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Error loading data \(error!.localizedDescription)")
                return
            }

            if data == nil {
                print("No data")
                return
            }

            self.movies = try? JSONDecoder().decode([MovieModel].self, from: data!)
        }

        task.resume()
        session.finishTasksAndInvalidate()
    }
}
