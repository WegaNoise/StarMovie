//
//  NetworkManager.swift
//  StarMovie
//
//  Created by petar on 08.05.2024.
//

import Foundation

protocol NetworkServicesMovie {
    func getPopularMovieList(complition: @escaping (Result<[Movie], Error>) -> Void)
}

final class NetworkManager: NetworkServicesMovie {
    
    static let shared = NetworkManager()
    
    private let errorManager = NertworkErrorManager()
    
    func geMovieListForHomePage() async throws -> [Movie]? {
        var movies:[Movie] = []
        for page in 1...5 {
            let url = URL(string: "https://api.themoviedb.org/3/discover/movie")!
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
            urlComponents?.queryItems = [URLQueryItem(name: "api_key", value: Resources.UrlMovieDB.keyApi),
                                         URLQueryItem(name: "include_adult", value: "true"),
                                         URLQueryItem(name: "page", value: "\(page)")]
            guard let urlWithComponents = urlComponents?.url else { throw NetworkErrors.invalidURL}
            let (data, _ ) = try await URLSession.shared.data(from: urlWithComponents)
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
    
    func getPopularMovieList(complition: @escaping (Result<[Movie], any Error>) -> Void) {
        guard let url = URL(string: "\(Resources.UrlMovieDB.baseURL)movie/popular?api_key=\(Resources.UrlMovieDB.keyApi)") else {
            complition(.failure(NetworkErrors.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url){ data, response, error in
            if let error = error as? URLError {
                complition(.failure(self.errorManager.defineError(error: error)))
                return
            }
            guard let data = data else {
                complition(.failure(NetworkErrors.invalidData))
                return
            }
            DispatchQueue.main.async {
                do{
                    let result = try JSONDecoder().decode(Movies.self, from: data)
                    complition(.success(result.results))
                }catch{
                    complition(.failure(NetworkErrors.invalidJSON))
                }
            }
        }.resume()
    }
    
    func getImageForMovie(imageLink: String) async throws -> Data{
        guard let url = URL(string: "\(Resources.UrlMovieDB.imageUrlPath)\(imageLink)") else {
            throw URLError(.badURL)}
        let (data, _ ) = try await URLSession.shared.data(from: url)
        return data
    }
    
    func searchMovieByID(id: Int) async throws -> Movie? {
        guard let url = URL(string: "\(Resources.UrlMovieDB.movieByIdUrlPath)\(id)?api_key=\(Resources.UrlMovieDB.keyApi)") else { return nil }
        let (data, _ ) = try await URLSession.shared.data(from: url)
        do {
            let result = try JSONDecoder().decode(Movie.self, from: data)
            return result
        } catch {
            return nil
        }
    }
    
    func getYouTubeTrailer(filmName: String, filmYear: String) async throws -> String? {
        guard let url = URL(string: "\(Resources.UrlYouTube.baseSearhcURL)?key=\(Resources.UrlYouTube.keyAPI)&q=\(filmName + " " + filmYear) trailer") else {
            throw NetworkErrors.invalidURL
        }
        let (data, _ ) = try await URLSession.shared.data(from: url)
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

    
    func searhMovie(query: String, complition: @escaping (Result<[Movie], any Error>) -> Void) {
        guard let url = URL(string: "\(Resources.UrlMovieDB.searchUrlPath)?api_key=\(Resources.UrlMovieDB.keyApi)&query=\(query)&include_adult=true") else {
            complition(.failure(NetworkErrors.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error as? URLError {
                complition(.failure(self.errorManager.defineError(error: error)))
                return
            }
            guard let data = data else {
                complition(.failure(NetworkErrors.invalidData))
                return
            }
            DispatchQueue.main.async {
                do {
                    let result = try JSONDecoder().decode(Movies.self, from: data)
                    complition(.success(result.results))
                } catch {
                    complition(.failure(NetworkErrors.invalidJSON))
                }
            }
        }.resume()
    }
    
    func getMovieListInGenre(genereID: String, complition: @escaping (Result<[Movie], any Error>) -> Void) {
        guard let url = URL(string: "\(Resources.UrlMovieDB.genreUrlPath)?api_key=\(Resources.UrlMovieDB.keyApi)&with_genres=\(genereID)&include_adult=true") else {
            complition(.failure(NetworkErrors.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error as? URLError {
                complition(.failure(self.errorManager.defineError(error: error)))
                return
            }
            guard let data = data else {
                complition(.failure(NetworkErrors.invalidData))
                return
            }
            DispatchQueue.main.async {
                do {
                    let result = try JSONDecoder().decode(Movies.self, from: data)
                    complition(.success(result.results))
                } catch {
                    complition(.failure(NetworkErrors.invalidJSON))
                }
            }
        }.resume()
    }
}
