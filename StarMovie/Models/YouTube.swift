//
//  YouTube.swift
//  StarMovie
//
//  Created by petar on 29.07.2024.
//

import Foundation

//model for parsing YouTubeAPI v3
struct YouTube: Codable {
    let pageInfo: PageInfo
    let items: [Item]
}

struct Item: Codable {
    let id: VideoInfo
}

struct VideoInfo: Codable {
    let kind, videoID: String
    
    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int
}
