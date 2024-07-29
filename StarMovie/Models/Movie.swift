//
//  Movie.swift
//  StarMovie
//
//  Created by petar on 09.05.2024.
//

import Foundation

struct Movies: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let originalTitle: String?
    let posterPath: String?
    let overview: String?
    let title: String?
    let mediaType: String?
    let releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    var imageData: Data?
    
    enum CodingKeys: String, CodingKey {
            case id
            case originalTitle = "original_title"
            case overview, title
            case posterPath = "poster_path"
            case mediaType = "media_type"
            case releaseDate = "release_date"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
            case imageData
        }
}

