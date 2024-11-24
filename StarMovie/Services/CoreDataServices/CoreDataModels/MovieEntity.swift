//
//  MovieEntity.swift
//  StarMovie
//
//  Created by petar on 07.11.2024.
//

import CoreData

@objc(MovieEntity)
public class MovieEntity: NSManagedObject {
    @NSManaged public var id : Int64
    @NSManaged public var posterData: Data?
    @NSManaged public var overview: String?
    @NSManaged public var title: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var lang: String?
    @NSManaged public var watchLater: Bool
    @NSManaged public var isRated: Bool
    @NSManaged public var trailerID: String?
    @NSManaged public var userRating: Int64
    @NSManaged public var isWatched: Bool
    
}
