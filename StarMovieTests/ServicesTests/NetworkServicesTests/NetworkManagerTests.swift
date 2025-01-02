//
//  NetworkManagerTests.swift
//  StarMovieTests
//
//  Created by petar on 30.12.2024.
//

import XCTest
@testable import StarMovie

final class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    var mockSession: URLSession!
    
    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        mockSession = URLSession(configuration: config)
        networkManager = NetworkManager(session: mockSession)
    }
    
    override func tearDown() {
        networkManager = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testGetMovieListForHomePage() async throws {
        guard let mockMovieData = NetworkManagerTests.createMockMovieListData() else { XCTFail("Failed to create mock movie data"); return }
        for page in 1...6 {
            guard let mockURL = networkManager.urlConfigurator(.homePage, with: page.description) else { XCTFail("Failed to create mock URL"); return }
            MockURLProtocol.mockResponses[mockURL] = (mockMovieData,
                                                      HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil),
                                                      nil)
        }
        let movies = try await networkManager.getMovieListForHomePage()
        XCTAssertEqual(movies?.count, 12)
        XCTAssertEqual(movies?.first?.overview, "Test Overview")
        XCTAssertEqual(movies?.first?.originalTitle, "Original Title Test")
    }

    func testGetImageForMovie() async throws {
        let mockImageData = Data(repeating: 0, count: 33)
        let mockImageLink = "TestImagePath"
        guard let mockURL = networkManager.urlConfigurator(.imageMovie, with: mockImageLink) else { XCTFail("Failed to create mock URL"); return }
        MockURLProtocol.mockResponses[mockURL] = (mockImageData,
                                                  HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil),
                                                  nil)
        let imageData = try await networkManager.getImageForMovie(imageLink: mockImageLink)
        XCTAssertEqual(imageData, mockImageData)
    }
    
    func testSearchMovieByID() async throws {
        let mockMovie = NetworkManagerTests.createMockMovieData()
        let movieID = 12345
        guard let mockURL = networkManager.urlConfigurator(.movieById, with: movieID.description) else { XCTFail("Failed to create mock URL"); return }
        MockURLProtocol.mockResponses[mockURL] = (mockMovie,
                                                  HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil),
                                                  nil)
        let returnedMovie = try await networkManager.searchMovieByID(id: movieID)
        XCTAssertEqual(returnedMovie?.title, "Test Movie 1")
        XCTAssertEqual(returnedMovie?.overview, "Test Overview One")
    }
    
    func testGetYouTubeTrailer() async throws {
        let mockInfo = YouTube(pageInfo: PageInfo(totalResults: 10, resultsPerPage: 10), items: [Item(id: VideoInfo(kind: "", videoID: "12345"))])
        let mockData = try JSONEncoder().encode(mockInfo)
        guard let mockURL = networkManager.urlConfigurator(.ytTrailer, with: "TestName TestYear") else { XCTFail("Failed to create mock URL"); return }
        MockURLProtocol.mockResponses[mockURL] = (mockData,
                                                  HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil),
                                                  nil)
        let ytVideoID = try await networkManager.getYouTubeTrailer(filmName: "TestName", filmYear: "TestYear")
        XCTAssertEqual(ytVideoID, "12345")
    }
    
    func testSearhMovieList() async throws {
        let mockSearchResults = NetworkManagerTests.createMockMovieListData()
        guard let mockURL = networkManager.urlConfigurator(.searchMovie, with: "Test") else { XCTFail("Failed to create mock URL"); return }
        MockURLProtocol.mockResponses[mockURL] = (mockSearchResults,
                                                  HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil),
                                                  nil)
        let returnedMovies = try await networkManager.searhMovieList(query: "Test")
        XCTAssertEqual(returnedMovies?.count, 2)
        XCTAssertEqual(returnedMovies?.first?.overview, "Test Overview")
    }
    
    func testGetMovieListInGenre() async throws {
        let mockGenreMovieList = NetworkManagerTests.createMockMovieListData()
        let mockGenreID = "12345"
        guard let mockURL = networkManager.urlConfigurator(.genreMovie, with: mockGenreID) else { XCTFail("Failed to create mock URL"); return }
        MockURLProtocol.mockResponses[mockURL] = (mockGenreMovieList,
                                                  HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil),
                                                  nil)
        let resultMovieList = try await networkManager.getMovieListInGenre(genereID: mockGenreID)
        XCTAssertEqual(resultMovieList.count, 2)
        XCTAssertEqual(resultMovieList.first?.overview, "Test Overview")
        XCTAssertEqual(resultMovieList.first?.originalTitle, "Original Title Test")
    }
}

extension NetworkManagerTests {
    static func createMockMovieListData() -> Data? {
        let mockMovies = MockMovies(results: [
            MockMovie(id: 1, originalTitle: "Original Title Test", overview: "Test Overview", title: "Test Movie 1", releaseDate: "2000-01-01"),
            MockMovie(id: 2, originalTitle: "Original Title Test", overview: "Test Overview", title: "Test Movie 2", releaseDate: "2000-01-01")
        ])
        return try? JSONEncoder().encode(mockMovies)
    }
    
    static func createMockMovieData() -> Data? {
        let mockMovie = MockMovie(id: 12345, originalTitle: "Original Title Test One", overview: "Test Overview One", title: "Test Movie 1", releaseDate: "2020-01-01")
        return try? JSONEncoder().encode(mockMovie)
    }
}
