//
//  MovieModel.swift
//  MovieTracker
//
//  Created by Ariel Hernández Amador for PMDM - iOS  2021.
//  https://github.com/gnuaha7/pmdm2021
//

import Foundation

struct MovieData: Decodable {
    var Title: String

    var Year: String
    var Runtime: String
    var Poster: String
    var imdbRating: String
    var Metascore: String
    var Plot: String
    var imdbID: String

    var Actors: String
    var Rated: String
    var Country: String
}
