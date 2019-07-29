//
//  TopRatedMoviesResponse.swift
//  MovieWebService
//
//  Created by Guillermo Gutierrez on 7/8/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//
import Foundation

public struct MoviesResponse: Codable, Response {
    public let page, totalResults, totalPages: Int
    public let results: [ResultMovie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - ResultMovie
public struct ResultMovie: Codable {
    public let voteCount, id: Int
    public let video: Bool?
    public let voteAverage: Double
    public let title: String
    public let popularity: Double
    public let posterPath, originalLanguage, originalTitle: String?
    public let genreIDS: [Int]?
    public let backdropPath: String?
    public let adult: Bool?
    public let overview, releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id, video
        case voteAverage = "vote_average"
        case title, popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case releaseDate = "release_date"
    }
}

