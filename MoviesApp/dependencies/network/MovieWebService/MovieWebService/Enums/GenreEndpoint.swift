//
//  GenreEndpoint.swift
//  MovieWebService
//
//  Created by Guillermo Gutierrez on 7/11/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

public enum GenreEndpoint: Endpoint {
    case moviesGenreList
    case tvGenreList
    
    public var url: URL? {
        return URL(string: self.stringValue)
    }
    
    var stringValue: String {
        switch self {
        case .moviesGenreList:
            return "https://api.themoviedb.org/3/genre/movie/list"
        case .tvGenreList:
            return "https://api.themoviedb.org/3/genre/tv/list"
        }
    }
    
    public var categoryDescription: String {
        return ""
    }
}
