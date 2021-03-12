//
//  MovieDetailViewController.swift
//  MovieTracker
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import UIKit

class MovieDetailViewController: UIViewController {

    var viewModel: MovieDetailViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            title = viewModel.title
            plotLabel.text = viewModel.plot
            extraDataLabel.text = viewModel.extraData
            titleLabel.text = viewModel.title
            yearLabel.text = viewModel.year
            runningTimeLabel.text = viewModel.runningTime
            imdbLabel.text = viewModel.imdbRating

            posterImageView.sd_setImage(with: viewModel.imageURL,
                                        placeholderImage: UIImage(named: "placeholder"))
            updateNavigationBarButtons()

            actorsLabel.text = viewModel.actors

            oldValue?.delegate = nil
            viewModel.delegate = self
        }
    }

    let contentStackView = UIStackView()
    let headerStackView = UIStackView()
    let extraDataLabel = UILabel()
    let actorsLabel = UILabel()
    let plotLabel = UILabel()
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let yearLabel = UILabel()
    let runningTimeLabel = UILabel()
    let imdbLabel = UILabel()
    let imdbImageView = UIImageView(image: UIImage(named:"imdb"))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.view.addSubview(contentStackView)

        contentStackView.spacing = 10
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical

        headerStackView.addArrangedSubview(posterImageView)

        let imdbStackView = UIStackView(arrangedSubviews: [
            imdbImageView,
            imdbLabel
        ])
        imdbStackView.spacing = 5

        let titlesStackView = UIStackView(arrangedSubviews: [titleLabel,
                                                             yearLabel,
                                                             runningTimeLabel,
                                                             imdbStackView
        ])
        titlesStackView.axis = .vertical

        headerStackView.addArrangedSubview(titlesStackView)
        headerStackView.spacing = 10
        headerStackView.alignment = .center

        posterImageView.contentMode = .scaleAspectFit
        imdbImageView.contentMode = .scaleAspectFit
        extraDataLabel.numberOfLines = 2
        plotLabel.numberOfLines = 0

        contentStackView.addArrangedSubview(headerStackView)
        contentStackView.addArrangedSubview(extraDataLabel)
        contentStackView.addArrangedSubview(actorsLabel)
        contentStackView.addArrangedSubview(plotLabel)
        contentStackView.addArrangedSubview(UIView())

        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            contentStackView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant:20),
            contentStackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 200),
            posterImageView.widthAnchor.constraint(equalToConstant: 150),
            imdbImageView.widthAnchor.constraint(equalToConstant: 40),
            imdbImageView.heightAnchor.constraint(equalToConstant: 35)
        ])


        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Track",
                            image: UIImage(systemName: "checkmark.square"),
                            primaryAction:UIAction { _ in self.viewModel?.toggleTracked()},
                            menu: nil),
            UIBarButtonItem(title: "Favorite",
                            image: UIImage(systemName: "suit.heart"),
                            primaryAction:UIAction { _ in self.viewModel?.toggleLoved()},
                            menu: nil)
        ]
        updateNavigationBarButtons()
    }
}

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func updateNavigationBarButtons () {
        let (trackedItem, favItem) = (navigationItem.rightBarButtonItems?[0],
                                      navigationItem.rightBarButtonItems?[1])

        trackedItem?.image = (viewModel?.tracked ?? false
                                ? UIImage(systemName: "checkmark.square.fill")
                                : UIImage(systemName: "checkmark.square"))
        favItem?.image = (viewModel?.loved ?? false
                                ? UIImage(systemName: "suit.heart.fill")
                                : UIImage(systemName: "suit.heart"))
    }

    func didChangedTrackedState(viewModel: MovieDetailViewModel) {
        updateNavigationBarButtons()
    }

    func didChangedLovedState(viewModel: MovieDetailViewModel) {
        updateNavigationBarButtons()
    }


}
