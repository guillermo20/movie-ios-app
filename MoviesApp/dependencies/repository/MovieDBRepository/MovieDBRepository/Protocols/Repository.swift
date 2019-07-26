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
    
    // handles all the fetch movies logic from local/remote store.
    func fetchMovies(pageNumber: Int, completion: @escaping ([Movie]?, Error?) -> Void)
    
    // intended to load an image to the movie object being passed as a paremeter
    func fetchMovieImage(movie: Movie, imageType: ImageType, completion: @escaping(Movie?, Error?) -> Void)

}

extension Repository {
    func fetchMovies(pageNumber: Int = 1, completion: @escaping ([Movie]?, Error?) -> Void) {
        fetchMovies(pageNumber: pageNumber, completion: completion)
    }
}
