//
//  MovieModel+Convenience.swift
//  MovieTracker
//
//  Created by Ariel Hernández Amador on 11/3/21.
//

import UIKit
import CoreData

extension MovieModel {

    static func getOrCreate(with movieData: MovieData) -> MovieModel {
        guard let context = AppDelegate.viewContext else { return MovieModel() }

        let request = NSFetchRequest<MovieModel>(entityName: "MovieModel")
        request.predicate = NSPredicate(format: "imdbId = %@", movieData.imdbID)

        if let movie = try? context.fetch(request).first {
            return movie
        } else {
            return MovieModel(context: context, movieData: movieData)
        }
    }

    convenience init(context:NSManagedObjectContext, movieData: MovieData) {
        self.init(context:context)

        title = movieData.Title
        year = Int16(movieData.Year) ?? 2021
        runtime = movieData.Runtime
        poster = URL(string: movieData.Poster)
        imdbRating = Float(movieData.imdbRating) ?? 0
        imdbId = movieData.imdbID
        metascore = Int16(movieData.Metascore) ?? 0
        plot = movieData.Plot

        rated = RatedModel.getOrCreate(with: movieData.Rated)

        for actor in movieData.Actors.split(separator: ",") {
            let actor = ActorModel.getOrCreate(with: String(actor))
            actors_.insert(actor)
        }

//        // Obtener o crear los objetos de las propiedades
//       Actors, Country y Rated
    }

    var title_: String {
        title ?? ""
    }

    var runtime_: String {
        runtime ?? "0 secs"
    }

    var plot_: String {
        plot ?? ""
    }

    var actors_: Set<ActorModel> {
        get {
            actors as? Set<ActorModel> ?? []
        }
        set {
            print(newValue)
            actors = newValue as NSSet
        }
    }
}
