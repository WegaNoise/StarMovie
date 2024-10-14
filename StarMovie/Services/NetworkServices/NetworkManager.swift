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
    
    func getImageForMovie(imageLink: String, complition: @escaping (_ imageData: Data) -> ()) {
        guard let url = URL(string: "\(Resources.UrlMovieDB.imageUrlPath)\(imageLink)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            complition(data)
        }.resume()
    }
    
    func getYouTubeTrailer(filmName: String, filmYear: String, complition: @escaping (Result<VideoInfo, any Error>) -> ()) {
        guard let url = URL(string: "\(Resources.UrlYouTube.baseSearhcURL)?key=\(Resources.UrlYouTube.keyAPI)&q=\(filmName + " " + filmYear) trailer") else {
            complition(.failure(NetworkErrors.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error as? URLError {
                complition(.failure(self.errorManager.defineError(error: error)))
                return
            }
            guard let data = data else {
                complition(.failure(NetworkErrors.trailerNotFound))
                return
            }
            DispatchQueue.main.async {
                do {
                    let result = try JSONDecoder().decode(YouTube.self, from: data)
                    complition(.success(result.items[0].id))
                } catch {
                    complition(.failure(error))
                }
            }
        }.resume()
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
