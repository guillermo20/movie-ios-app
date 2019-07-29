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
    
   
    func fetchTopRatedMovies(pageNumber: Int, completion: @escaping ([Movie]?, Error?) -> Void)
    
    func fetchPopularMovies(pageNumber: Int, completion: @escaping ([Movie]?, Error?) -> Void)
    
    func fetchUpcomingMovies(pageNumber: Int, completion: @escaping ([Movie]?, Error?) -> Void)
    
    func fetchAllMovies(completion: @escaping ([Movie]?, Error?) -> Void)
    
    // intended to load an image to the movie object being passed as a paremeter
    func fetchMovieImage(movie: Movie, imageType: ImageType, completion: @escaping(Movie?, Error?) -> Void)

}

extension Repository {
    func fetchTopRatedMovies(pageNumber: Int = 1, completion: @escaping ([Movie]?, Error?) -> Void) {
        fetchTopRatedMovies(pageNumber: pageNumber, completion: completion)
    }
    func fetchPopularMovies(pageNumber: Int = 1, completion: @escaping ([Movie]?, Error?) -> Void) {
        fetchTopRatedMovies(pageNumber: pageNumber, completion: completion)
    }
    func fetchUpcomingMovies(pageNumber: Int = 1, completion: @escaping ([Movie]?, Error?) -> Void) {
        fetchTopRatedMovies(pageNumber: pageNumber, completion: completion)
    }
}
