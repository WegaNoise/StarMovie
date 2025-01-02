//
//  MockMovie.swift
//  StarMovieTests
//
//  Created by petar on 31.12.2024.
//

import Foundation

struct MockMovies: Codable {
    let results: [MockMovie]
}

struct MockMovie: Codable {
    let id: Int
    let originalTitle: String
    let overview: String
    let title: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview
        case title
        case releaseDate = "release_date"
    }
}
