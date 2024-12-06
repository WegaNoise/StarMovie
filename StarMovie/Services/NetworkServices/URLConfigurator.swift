//
//  URLConfigurator.swift
//  StarMovie
//
//  Created by petar on 25.11.2024.
//

import Foundation
enum UrlConfig {
    case homePage
    case imageMovie
    case movieById
    case ytTrailer
    case searchMovie
    case genreMovie

    var baseURL: String {
        switch self {
        case .homePage:
            return Resources.UrlMovieDB.searchMovieListPath
        case .imageMovie:
            return Resources.UrlMovieDB.imageUrlPath
        case .movieById:
            return Resources.UrlMovieDB.movieByIdUrlPath
        case .ytTrailer:
            return Resources.UrlYouTube.baseSearhcURL
        case .searchMovie:
            return Resources.UrlMovieDB.searchUrlPath
        case .genreMovie:
            return Resources.UrlMovieDB.searchMovieListPath
        }
    }

    var defaultQueryItems: [URLQueryItem] {
        switch self {
        case .homePage, .searchMovie, .genreMovie, .movieById:
            return [URLQueryItem(name: "api_key", value: Resources.UrlMovieDB.keyApi),
                    URLQueryItem(name: "include_adult", value: "true")]
        case .ytTrailer:
            return [URLQueryItem(name: "key", value: Resources.UrlYouTube.keyAPI)]
        case .imageMovie:
            return []
        }
    }
}

extension NetworkManager {
    func urlConfigurator(_ config: UrlConfig, with query: String?) -> URL? {
        
        guard var urlComponents = URLComponents(string: config.baseURL) else { return nil }
        var queryItems = config.defaultQueryItems
        
        switch config {
        case .homePage:
            queryItems.append(URLQueryItem(name: "page", value: query))
        case .imageMovie:
            return URL(string: "\(config.baseURL)\(query ?? "")")
        case .movieById:
            guard let movieID = query else { return nil }
            urlComponents.path.append("\(movieID)")
        case .ytTrailer:
            guard let query = query else { return nil }
            let trailerQuery = "\(query) trailer"
            queryItems.append(URLQueryItem(name: "q", value: trailerQuery))
        case .searchMovie:
            queryItems.append(URLQueryItem(name: "query", value: query))
        case .genreMovie:
            queryItems.append(URLQueryItem(name: "with_genres", value: query))
        }
        
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}
