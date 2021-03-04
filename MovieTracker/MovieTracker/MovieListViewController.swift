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

        tableView.register(MovieCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        title = "Movies"
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
        return viewModel.numberOfMovies(startingBy: letter)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MovieCell

        if let viewModel = viewModel {
            cell.viewModel = viewModel.movieCellViewModel(forMovieAt:indexPath)
        }
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension MovieListViewController {
    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {

        let childViewModel = viewModel?.movieDetailViewModel(forMovieAt: indexPath)
        let childViewController = MovieDetailViewController()
        childViewController.viewModel = childViewModel

        navigationController?.pushViewController(childViewController, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
}

extension MovieListViewController: MovieListViewModelDelegate {
    func didUpdateMovies(viewModel: MovieListViewModel)
    {
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
}
