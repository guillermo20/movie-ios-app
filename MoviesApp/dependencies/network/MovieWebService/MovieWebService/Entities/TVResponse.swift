//
//  TVResponse.swift
//  MovieWebService
//
//  Created by Guillermo Gutierrez on 7/8/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

struct TVResponse: Codable, Response {
    let page, totalResults, totalPages: Int
    let results: [ResultTV]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - ResultTV
struct ResultTV: Codable {
    let originalName: String
    let genreIDS: [Int]
    let name: String
    let popularity: Double
    let originCountry: [String]
    let voteCount: Int
    let firstAirDate, backdropPath, originalLanguage: String
    let id: Int
    let voteAverage: Double
    let overview, posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case name, popularity
        case originCountry = "origin_country"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case id
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
    }
}
