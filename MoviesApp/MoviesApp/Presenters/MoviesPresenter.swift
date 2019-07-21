//
//  MoviesPresenter.swift
//  MoviesApp
//
//  Created by Guillermo Gutierrez on 7/18/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation
import MovieDBRepository
import MovieDataBase


class MoviesPresenter {
    
    weak private var viewDelegate: MoviesViewDelegate?
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func setViewDelegate(viewDelegate: MoviesViewDelegate) {
        self.viewDelegate = viewDelegate
    }
    
    func fetchMovies() {
        self.repository.fetchMovies { (movies, error) in
            guard let movies = movies else {
                self.viewDelegate?.showError(message: error?.localizedDescription ??
                    MessageConstants.genericErrorMessage)
                return
            }
            self.viewDelegate?.displayMovies(movies: movies)
        }
    }
    
    func fetchMovieImage(movie: Movie) {
        self.repository.fetchMovieImage(movie: movie, imageType: .posterImage) { (data, error) in
            guard let data = data else {
                self.viewDelegate?.showError(message: MessageConstants.genericErrorMessage)
                return
            }
            self.viewDelegate?.updateMovieImage(data: data)
        }
    }
    
}
