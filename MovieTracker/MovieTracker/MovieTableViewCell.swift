//
//  MovieTableViewCell.swift
//  MovieTracker
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    var movie: MovieModel? {
        didSet {
            if let movie = movie {
                self.textLabel?.text = "\(movie.Title) (\(movie.Year))"
                self.detailTextLabel?.text = movie.Runtime
            } else {
                self.textLabel?.text = ""
                self.detailTextLabel?.text = ""
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
