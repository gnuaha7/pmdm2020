//
//  MovieCell.swift
//  MovieTracker
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {

    var viewModel: MovieCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }

            titleLabel.text = viewModel.title
            subtitleLabel.text = viewModel.subtitleLabel
            ratingLabel.text = viewModel.rating

            posterImageView.sd_setImage(with: viewModel.imageURL,
                                        placeholderImage: UIImage(named: "placeholder"))
        }
    }

    let contentStackView = UIStackView()
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let ratingLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(posterImageView)

        let titlesStackView = UIStackView(arrangedSubviews: [UIView(), titleLabel, subtitleLabel, UIView()])
        titlesStackView.axis = .vertical
        titlesStackView.distribution = .fillEqually

        contentStackView.addArrangedSubview(titlesStackView)
        contentStackView.addArrangedSubview(ratingLabel)

        posterImageView.contentMode = .scaleAspectFit

        contentStackView.spacing = 5
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        ratingLabel.setContentHuggingPriority(.required, for: .horizontal)

        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            contentStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 55)
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
