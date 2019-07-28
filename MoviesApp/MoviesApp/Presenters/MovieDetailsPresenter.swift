//
//  MovieDetailsPresenter.swift
//  MoviesApp
//
//  Created by Guillermo Gutierrez on 7/26/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation
import MovieDBRepository
import MovieDataBase


class MovieDetailsPresenter  {
    
    
    let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    // loads a image directly to the Movie object
    func fetchMovieBackdropImage(movie: Movie, completion: @escaping (Movie?) -> Void) {
        self.repository.fetchMovieImage(movie: movie, imageType: .backdropImage) { (movie, error) in
            guard let movie = movie else {
//                self.viewDelegate?.showError(message: MessageConstants.genericErrorMessage)
                return
            }
            completion(movie)
        }
    }

}

