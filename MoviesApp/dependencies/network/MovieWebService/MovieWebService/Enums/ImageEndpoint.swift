//
//  ImageEndpoint.swift
//  MovieWebService
//
//  Created by Guillermo Gutierrez on 7/20/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation


public enum ImageEndpoint: Endpoint {
    
    case defaultPosterURL(String)
    case defaultBackdropURL(String)
    
    public var url: URL? {
        return URL(string: self.stringValue)
    }
    
    var stringValue: String {
        switch self {
        case .defaultPosterURL(let filepath):
            return "https://image.tmdb.org/t/p/w342\(filepath)"
        case .defaultBackdropURL(let filepath):
            return "https://image.tmdb.org/t/p/w780\(filepath)"
        }
    }
}
