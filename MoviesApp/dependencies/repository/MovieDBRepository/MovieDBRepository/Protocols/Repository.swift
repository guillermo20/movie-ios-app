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
    

    func fetchMovies(completion: @escaping ([Movie]?, Error?) -> Void)
    func fetchMovieImage(movie: Movie, imageType: ImageType, completion: @escaping(Data?, Error?) -> Void)

}
