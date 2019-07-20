//
//  Repository.swift
//  MovieDBRepository
//
//  Created by Guillermo Gutierrez on 7/13/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation
import MovieDataBase

public protocol Repository {
    
//    func loadGenres(completion: @escaping ([Genre]?, Error?) -> Void)
    func fetchMovies(completion: @escaping ([Movie]?, Error?) -> Void)
//    func fetchGenres()
//    func fetchMovies()
//    func fetchTVSeries()
}
