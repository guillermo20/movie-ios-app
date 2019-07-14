//
//  MovieEnpoint.swift
//  MovieWebService
//
//  Created by Guillermo Gutierrez on 7/8/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

/// especifies the Movies endpoint and its categories
enum MovieEndpoint: Endpoint {
    
    case topRated
    case popular
    case upcoming
    
    var url: URL? {
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
    
    
}
