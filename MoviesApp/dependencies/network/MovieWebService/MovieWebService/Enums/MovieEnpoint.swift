//
//  MovieEnpoint.swift
//  MovieWebService
//
//  Created by Guillermo Gutierrez on 7/8/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

/// especifies the Movies endpoint and its categories
public enum MovieEndpoint: String, Endpoint  {
    
    case topRated
    case popular
    case upcoming
    
    public var url: URL? {
        return URL(string: self.stringValue)
    }
    
    var stringValue: String {
        switch self {
        case .topRated:
            return "https://api.themoviedb.org/3/movie/top_rated"
        case .popular:
            return "https://api.themoviedb.org/3/movie/popular"
        case .upcoming:
            return "https://api.themoviedb.org/3/movie/upcoming"
        }
    }
    
    public var categoryDescription: String {
        return self.rawValue
    }
}
