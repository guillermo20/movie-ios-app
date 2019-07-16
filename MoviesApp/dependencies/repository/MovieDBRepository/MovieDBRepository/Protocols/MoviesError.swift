//
//  MoviesError.swift
//  MovieDBRepository
//
//  Created by Guillermo Gutierrez on 7/15/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

public struct MoviesError: Error {
    
    public let message: String!
    
    init(message: String) {
        self.message = message
    }
}
