//
//  ViewController.swift
//  MovieTracker
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import UIKit

class MovieListViewController: UITableViewController {
    let cellReuseIdentifier = "default.movie.cell"

    var viewModel: MovieListViewModel? {
        didSet {
            oldValue?.delegate = nil
            viewModel?.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
}

// MARK: UITableViewDataSource
extension MovieListViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.sectionIndexes.count ?? 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel?.sectionIndexes[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let viewModel = viewModel else {
            return 0
        }

        let letter = viewModel.sectionIndexes[section]
        return viewModel.movies(startingBy: letter).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MovieTableViewCell

        if let viewModel = viewModel {
            let letter = viewModel.sectionIndexes[indexPath.section]
            let movies = viewModel.movies(startingBy: letter)
            cell.movie = movies[indexPath.row]
        }
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension MovieListViewController {
    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapp at \(indexPath.section),\(indexPath.row)")
    }

}

extension MovieListViewController: MovieListViewModelDelegate {
    func didUpdateMovies(viewModel: MovieListViewModel)
    {
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
}
