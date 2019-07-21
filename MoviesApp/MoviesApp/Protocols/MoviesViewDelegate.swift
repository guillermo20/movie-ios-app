//
//  MoviesViewDelegate.swift
//  MoviesApp
//
//  Created by Guillermo Gutierrez on 7/18/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation
import MovieDataBase

protocol MoviesViewDelegate: NSObjectProtocol {
    
    func displayMovies(movies: [Movie])
    func updateMovieImage(data: Data)
    func showError(message: String)
    
}
