//
//  NetworkManager.swift
//  StarMovie
//
//  Created by petar on 08.05.2024.
//

import Foundation

protocol NetworkServicesProtocol {
    
}

final class NetworkManager: NetworkServicesProtocol {
    static let shared = NetworkManager(session: URLSession(configuration: .default))
    private let errorManager = NertworkErrorManager()
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func getMovieListForHomePage() async throws -> [Movie]? {
        var movies:[Movie] = []
        for page in 1...6 {
            guard let url = urlConfigurator(.homePage, with: page.description) else { throw NetworkErrors.invalidURL }
            let (data, _ ) = try await session.data(from: url)
            do {
                let result = try JSONDecoder().decode(Movies.self, from: data)
                for movie in result.results {
                    movies.append(movie)
                }
            } catch {
                throw NetworkErrors.invalidData
            }
        }
        return movies
    }
    
    func getImageForMovie(imageLink: String) async throws -> Data {
        guard let url = urlConfigurator(.imageMovie, with: imageLink) else { throw NetworkErrors.invalidURL }
        let (data, _ ) = try await session.data(from: url)
        return data
    }
    
    func searchMovieByID(id: Int) async throws -> Movie? {
        guard let url = urlConfigurator(.movieById, with: id.description) else { throw NetworkErrors.invalidURL }
        let (data, _ ) = try await session.data(from: url)
        do {
            let result = try JSONDecoder().decode(Movie.self, from: data)
            return result
        } catch {
            throw NetworkErrors.invalidData
        }
    }
    
    func getYouTubeTrailer(filmName: String, filmYear: String) async throws -> String? {
        let query = "\(filmName) \(filmYear)"
        guard let url = urlConfigurator(.ytTrailer, with: query) else { throw NetworkErrors.invalidURL }
        let (data, _ ) = try await session.data(from: url)
        do {
            let result = try JSONDecoder().decode(YouTube.self, from: data)
            guard let videoId = result.items.first?.id.videoID else {
                return nil
            }
            return videoId
        } catch {
            return nil
        }
    }
    
    func searhMovieList(query: String) async throws -> [Movie]? {
        guard let url = urlConfigurator(.searchMovie, with: query) else { throw NetworkErrors.invalidURL }
        let (data, _) = try await session.data(from: url)
        do {
            let result = try JSONDecoder().decode(Movies.self, from: data)
            return result.results
        } catch {
            throw NetworkErrors.invalidJSON
        }
    }
    
    func getMovieListInGenre(genereID: String) async throws -> [Movie] {
        guard let url = urlConfigurator(.genreMovie, with: genereID) else { throw NetworkErrors.invalidURL }
        let (data, _) = try await session.data(from: url)
        do {
            let result = try JSONDecoder().decode(Movies.self, from: data)
            return result.results
        } catch {
            throw NetworkErrors.invalidJSON
        }
    }
}
