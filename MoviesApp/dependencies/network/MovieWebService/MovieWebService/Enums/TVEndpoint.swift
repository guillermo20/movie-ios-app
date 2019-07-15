//
//  TVEndpoint.swift
//  MovieWebService
//
//  Created by Guillermo Gutierrez on 7/8/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

/// especifies the TV Series endpoint and its categories
public enum TVEndpoint: Endpoint {
    
    case topRated
    case popular
    
    public var url: URL? {
        return URL(string: self.stringValue)
    }
    
    var stringValue: String {
        switch self {
        case .topRated:
            return "https://api.themoviedb.org/3/tv/top_rated"
        case .popular:
            return "https://api.themoviedb.org/3/tv/popular"
        }
    }
    
}
