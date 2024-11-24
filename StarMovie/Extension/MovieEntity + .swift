//
//  MovieEntity + .swift
//  StarMovie
//
//  Created by petar on 08.11.2024.
//

import Foundation
import CoreData

extension MovieEntity {
    convenience init(movie: Movie, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = Int64(movie.id)
        self.title = movie.title
        self.overview = movie.overview
        self.posterData = movie.posterData
        self.releaseDate = movie.releaseDate
        self.lang = movie.lang
    }
}
