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
    let releaseDate: Date?
    let voteAverage: Double?
    let voteCount: Int?
    let lang: String?
    var posterData: Data?
    var trailerID: String?
    var watchLater: Bool?
    var userRating: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview, title
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case lang = "original_language"
        case trailerID, watchLater, posterData, userRating
    }
  
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.mediaType = try container.decodeIfPresent(String.self, forKey: .mediaType)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let release = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.releaseDate = dateFormatter.date(from: release ?? "2000-01-01")
        self.voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
        self.lang = try container.decodeIfPresent(String.self, forKey: .lang)
        self.trailerID = try container.decodeIfPresent(String.self, forKey: .trailerID)
        self.watchLater = try container.decodeIfPresent(Bool.self, forKey: .watchLater)
        self.watchLater = try container.decodeIfPresent(Bool.self, forKey: .watchLater)
        self.userRating = try container.decodeIfPresent(Int.self, forKey: .userRating)
    }
}

