//
//  RatedModel+Convenience.swift
//  MovieTracker
//
//  Created by Ariel Hernández Amador on 11/3/21.
//

import UIKit
import CoreData

extension RatedModel {

    static func getOrCreate(with name: String) -> RatedModel
    {
        guard let context = AppDelegate.viewContext else {
            return RatedModel(name: name)
        }

        let request = NSFetchRequest<RatedModel>(entityName: "RatedModel")
        request.predicate = NSPredicate(format: "name = %@", name)

        if let rated = try? context.fetch(request).first {
            return rated
        } else {
            return RatedModel(context: context, name:name)
        }
    }

    convenience init(context:NSManagedObjectContext, name: String) {
        self.init(context:context)
        self.name = name
    }

    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
