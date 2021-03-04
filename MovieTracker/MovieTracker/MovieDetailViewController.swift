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
            ratingLabel.text = viewModel.rating

            guard let url = viewModel.imageURL else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            self.posterImageView.image = UIImage(data: data)
        }
    }

    let contentStackView = UIStackView()
    let headerStackView = UIStackView()
    let extraDataLabel = UILabel()
    let plotLabel = UILabel()
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let yearLabel = UILabel()
    let runningTimeLabel = UILabel()
    let ratingLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.view.backgroundColor = .white

        self.view.addSubview(contentStackView)

        contentStackView.spacing = 10
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical

        headerStackView.addArrangedSubview(posterImageView)

        let titlesStackView = UIStackView(arrangedSubviews: [titleLabel,
                                                             yearLabel,
                                                             runningTimeLabel,
                                                             ratingLabel])
        titlesStackView.axis = .vertical

        headerStackView.addArrangedSubview(titlesStackView)
        headerStackView.spacing = 10
        headerStackView.alignment = .center

        posterImageView.contentMode = .scaleAspectFit
        extraDataLabel.numberOfLines = 2
        plotLabel.numberOfLines = 0

        contentStackView.addArrangedSubview(headerStackView)
        contentStackView.addArrangedSubview(extraDataLabel)
        contentStackView.addArrangedSubview(plotLabel)
        contentStackView.addArrangedSubview(UIView())

        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            contentStackView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant:20),
            contentStackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 200),
            posterImageView.widthAnchor.constraint(equalToConstant: 150)
        ])

        let action = UIAction { _ in
            guard let viewModel = self.viewModel else { return }
            let activityViewController = UIActivityViewController(activityItems: [
                                                                    viewModel.imageURL!,
                                                                    viewModel.title],
                                                                  applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share",
                                                            image: UIImage(systemName: "square.and.arrow.up"),
                                                            primaryAction:action,
                                                            menu: nil)
    }
}
