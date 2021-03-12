//
//  ActorModel+Convenience.swift
//  MovieTracker
//
//  Created by Ariel Hernández Amador on 11/3/21.
//

import UIKit
import CoreData

extension ActorModel {

    static func getOrCreate(with name: String) -> ActorModel
    {
        guard let context = AppDelegate.viewContext else {
            return ActorModel(name: name)
        }

        let request = NSFetchRequest<ActorModel>(entityName: "ActorModel")
        request.predicate = NSPredicate(format: "name = %@", name)

        if let actor = try? context.fetch(request).first {
            return actor
        } else {
            return ActorModel(context: context, name:name)
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

    var name_: String {
        name ?? ""
    }
}
