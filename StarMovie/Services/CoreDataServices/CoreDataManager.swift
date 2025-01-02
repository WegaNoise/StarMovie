//
//  CoreDataManager.swift
//  StarMovie
//
//  Created by petar on 07.11.2024.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    var persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "StarMovieDataBase", managedObjectModel: CoreDataManager.createManagerObjectModel())
        persistentContainer.loadPersistentStores{ storageDiscriptio, error in
            if let error = error {
                fatalError("Fatal error - Core Data failed to load:\(error.localizedDescription)")
            }
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Error saving context: \(nsError)")
            }
        }
    }
    
    func fetchMovieByID(_ id: Int) -> MovieEntity? {
        let request = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        request.predicate = NSPredicate(format: "id == \(id)")
        do {
            return try context.fetch(request).first
        } catch {
            print("Failed to fetch movie by id: \(error)")
            return nil
        }
    }
    
    func addMovieToWatchLater(movie: Movie) {
        if let existingMovie = fetchMovieByID(movie.id) {
            existingMovie.watchLater = true
        } else {
            let newMovieEntity = MovieEntity(movie: movie, context: context)
            newMovieEntity.watchLater = true
        }
        saveContext()
    }
    
    func updateMovieRating(movie: Movie, newRating: Int) {
        if let existingMovie = fetchMovieByID(movie.id) {
            if newRating > 0 {
                existingMovie.userRating = Int64(newRating)
                existingMovie.isRated = true
            } else {
                existingMovie.userRating = 0
                existingMovie.isRated = false
                if !existingMovie.watchLater {
                    context.delete(existingMovie)
                }
            }
        } else {
            if newRating > 0 {
                let newMovieEntity = MovieEntity(movie: movie, context: context)
                newMovieEntity.userRating = Int64(newRating)
                newMovieEntity.isRated = true
            } else {
                return
            }
        }
        saveContext()
    }
    
    func removeMovieFromWatchLater(movie: Movie) {
        if let existingMovie = fetchMovieByID(movie.id) {
            if existingMovie.isRated == false {
                context.delete(existingMovie)
            } else {
                existingMovie.watchLater = false
            }
            saveContext()
        }
    }
    
    func fatchWatchLaterMovies() -> [MovieEntity] {
        let request = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        let sortDescriptor = NSSortDescriptor(key: "isWatched", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        request.predicate = NSPredicate(format: "watchLater == true")
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch watch-later movies: \(error)")
            return []
        }
    }
    
    func fatchRatedMovies() -> [MovieEntity] {
        let request = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        request.predicate = NSPredicate(format: "isRated == true")
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch rated movies: \(error)")
            return []
        }
    }
    
    func changePropertyIsWatched(movieID: Int) {
        if let existingMovie = fetchMovieByID(movieID) {
            if existingMovie.watchLater == true {
                existingMovie.isWatched = !existingMovie.isWatched
            }
            saveContext()
        }
    }
    
    //  Method for tests
    func clearAllStarMovieDataBase() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = MovieEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            saveContext()
        } catch {
            print("Failed clear all star movie data base: \(error.localizedDescription)")
        }
    }
}

extension CoreDataManager {
    static func createManagerObjectModel() -> NSManagedObjectModel {
        let model = NSManagedObjectModel()
        
        let entity = NSEntityDescription()
        entity.name = "MovieEntity"
        entity.managedObjectClassName = NSStringFromClass(MovieEntity.self)
        
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.attributeType = .integer64AttributeType
        idAttribute.isOptional = false
        
        let posterDataAttribute = NSAttributeDescription()
        posterDataAttribute.name = "posterData"
        posterDataAttribute.attributeType = .binaryDataAttributeType
        posterDataAttribute.isOptional = true
        
        let owerviewAttribute = NSAttributeDescription()
        owerviewAttribute.name = "overview"
        owerviewAttribute.attributeType = .stringAttributeType
        owerviewAttribute.isOptional = true
        
        let titleAttribute = NSAttributeDescription()
        titleAttribute.name = "title"
        titleAttribute.attributeType = .stringAttributeType
        titleAttribute.isOptional = true
        
        let releaseDateAttribute = NSAttributeDescription()
        releaseDateAttribute.name = "releaseDate"
        releaseDateAttribute.attributeType = .dateAttributeType
        releaseDateAttribute.isOptional = true
        
        let langAttribute = NSAttributeDescription()
        langAttribute.name = "lang"
        langAttribute.attributeType = .stringAttributeType
        langAttribute.isOptional = true
        
        let watchedAttribute = NSAttributeDescription()
        watchedAttribute.name = "watchLater"
        watchedAttribute.attributeType = .booleanAttributeType
        watchedAttribute.isOptional = false
        watchedAttribute.defaultValue = false
        
        let isRatedAttribute = NSAttributeDescription()
        isRatedAttribute.name = "isRated"
        isRatedAttribute.attributeType = .booleanAttributeType
        isRatedAttribute.isOptional = false
        isRatedAttribute.defaultValue = false
        
        let trailerIDAttribute = NSAttributeDescription()
        trailerIDAttribute.name = "trailerID"
        trailerIDAttribute.attributeType = .stringAttributeType
        trailerIDAttribute.isOptional = true
        trailerIDAttribute.defaultValue = nil
        
        
        let userRatingAttribute = NSAttributeDescription()
        userRatingAttribute.name = "userRating"
        userRatingAttribute.attributeType = .integer64AttributeType
        userRatingAttribute.isOptional = true
        userRatingAttribute.defaultValue = 0
        
        let isWatchedAttribute = NSAttributeDescription()
        isWatchedAttribute.name = "isWatched"
        isWatchedAttribute.attributeType = .booleanAttributeType
        isWatchedAttribute.isOptional = false
        isWatchedAttribute.defaultValue = false
        
        entity.properties = [idAttribute,
                             posterDataAttribute,
                             owerviewAttribute,
                             titleAttribute,
                             releaseDateAttribute,
                             langAttribute,
                             watchedAttribute,
                             isRatedAttribute,
                             trailerIDAttribute,
                             userRatingAttribute,
                             isWatchedAttribute]
        
        model.entities = [entity]
        
        return model
    }
}
