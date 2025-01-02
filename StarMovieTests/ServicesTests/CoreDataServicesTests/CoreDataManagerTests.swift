//
//  CoreDataManagerTests.swift
//  CoreDataManagerTests
//
//  Created by petar on 27.12.2024.
//

import XCTest
import CoreData
@testable import StarMovie

final class CoreDataManagerTests: XCTestCase {
    var coreDataManager : CoreDataManager!
    
    override func setUp() {
        super.setUp()
        let mochModel = CoreDataManager.createManagerObjectModel()
        let mochPersistentContainer =  NSPersistentContainer(name: "StarMovieDB",managedObjectModel: mochModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        mochPersistentContainer.persistentStoreDescriptions = [description]
        mochPersistentContainer.loadPersistentStores { _, error in
            XCTAssertNil(error, "error creating test database")
        }
        coreDataManager = CoreDataManager.shared
        coreDataManager.persistentContainer = mochPersistentContainer
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
    }
    
    func testAddMovieToWatchLater() {
        let movieOne = try! CoreDataManagerTests.createMockMovie(id: 1)
        coreDataManager.addMovieToWatchLater(movie: movieOne)
        let fetchRequest = coreDataManager.fatchWatchLaterMovies()
        XCTAssertEqual(fetchRequest.first?.id, 1)
        XCTAssertEqual(fetchRequest.first?.title, "Test Movie")
        XCTAssertEqual(fetchRequest.first?.watchLater, true)
    }
    
    func testUpdateMovieRating() {
        let movieOne = try! CoreDataManagerTests.createMockMovie(id: 1)
        let movieTwo = try! CoreDataManagerTests.createMockMovie(id: 2)
        coreDataManager.updateMovieRating(movie: movieOne, newRating: 5)
        coreDataManager.updateMovieRating(movie: movieTwo, newRating: 3)
        let fetchRequest = coreDataManager.fatchRatedMovies()
        XCTAssertEqual(fetchRequest.count, 2)
        XCTAssertEqual(fetchRequest.first?.isRated, true)
        XCTAssertEqual(fetchRequest.last?.isRated, true)
        coreDataManager.updateMovieRating(movie: movieOne, newRating: 0)
        let fetchRequestTwo = coreDataManager.fatchRatedMovies()
        XCTAssertEqual(fetchRequestTwo.count, 1)
    }
    
    func testRemoveMovieFromWatchLater() {
        let movie = try! CoreDataManagerTests.createMockMovie(id: 1)
        coreDataManager.addMovieToWatchLater(movie: movie)
        let fetchRequest = coreDataManager.fatchWatchLaterMovies()
        XCTAssertEqual(fetchRequest.count, 1)
        XCTAssertEqual(fetchRequest.first?.id, 1)
        XCTAssertEqual(fetchRequest.first?.watchLater, true)
        coreDataManager.removeMovieFromWatchLater(movie: movie)
        let fetchRequestTwo = coreDataManager.fatchWatchLaterMovies()
        XCTAssertEqual(fetchRequestTwo.count, 0)
    }
    
    func testFatchWatchLaterMovies() {
        let movieOne = try! CoreDataManagerTests.createMockMovie(id: 1)
        let movieTwo = try! CoreDataManagerTests.createMockMovie(id: 2)
        let movieThree = try! CoreDataManagerTests.createMockMovie(id: 3)
        coreDataManager.addMovieToWatchLater(movie: movieOne)
        coreDataManager.addMovieToWatchLater(movie: movieTwo)
        coreDataManager.addMovieToWatchLater(movie: movieThree)
        let fetchRequest = coreDataManager.fatchWatchLaterMovies()
        XCTAssertEqual(fetchRequest.count, 3)
    }
    
    func testFatchRatedMovies() {
        let movieOne = try! CoreDataManagerTests.createMockMovie(id: 1)
        let movieTwo = try! CoreDataManagerTests.createMockMovie(id: 2)
        let movieThree = try! CoreDataManagerTests.createMockMovie(id: 3)
        coreDataManager.updateMovieRating(movie: movieOne, newRating: 1)
        coreDataManager.updateMovieRating(movie: movieTwo, newRating: 2)
        coreDataManager.updateMovieRating(movie: movieThree, newRating: 3)
        let fetchRequest = coreDataManager.fatchRatedMovies()
        XCTAssertEqual(fetchRequest.count, 3)
    }
    
    func testFetchMovieByID() {
        let movie = try! CoreDataManagerTests.createMockMovie(id: 1)
        coreDataManager.addMovieToWatchLater(movie: movie)
        let fetchedMovie = coreDataManager.fetchMovieByID(1)
        XCTAssertEqual(fetchedMovie?.title, "Test Movie")
    }
    
    func testChangePropertyIsWatched() {
        let movie = try! CoreDataManagerTests.createMockMovie(id: 1)
        coreDataManager.addMovieToWatchLater(movie: movie)
        let fetchedMovie = coreDataManager.fetchMovieByID(1)
        XCTAssertEqual(fetchedMovie?.isWatched, false)
        coreDataManager.changePropertyIsWatched(movieID: movie.id)
        let fetchRequest = coreDataManager.fetchMovieByID(1)
        XCTAssertEqual(fetchRequest?.isWatched, true)
    }
    
}

extension CoreDataManagerTests {
    static func createMockMovieJSONData(id: String) -> Data {
        return """
    {
        "id": \(id),
        "original_title": "Original Title Test",
        "overview": "Test Overview",
        "title": "Test Movie",
        "poster_path": null,
        "media_type": null,
        "release_date": null,
        "vote_average": null,
        "vote_count": null,
        "original_language": null,
        "trailerID": null,
        "watchLater": null,
        "userRating": null,
        "watchLaterButton": null
    }
    """.data(using: .utf8)!
    }
    
    static func createMockMovie(id: Int) throws -> Movie {
       let decoder = JSONDecoder()
        let movie = try decoder.decode(Movie.self, from: CoreDataManagerTests.createMockMovieJSONData(id: id.description))
       return movie
    }
}
