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
    
    private var pageNumber = 1
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func setViewDelegate(viewDelegate: MoviesViewDelegate) {
        self.viewDelegate = viewDelegate
    }
    
    // fetches movie objects from repository and handles the page number requested by the user interaction
    func fetchMovies(moreData: Bool = false) {
        if !moreData {
            pageNumber = 1
        } else {
            pageNumber = pageNumber + 1
        }
        self.repository.fetchMovies(pageNumber: pageNumber) { (movies, error) in
            guard let movies = movies else {
                self.viewDelegate?.showError(message: error?.localizedDescription ??
                    MessageConstants.genericErrorMessage)
                return
            }
            self.viewDelegate?.displayMovies(movies: movies)
        }
    }
    
    // loads a image directly to the Movie object
    func fetchMovieImage(movie: Movie, completion: @escaping (Movie?) -> Void) {
        self.repository.fetchMovieImage(movie: movie, imageType: .posterImage) { (movie, error) in
            guard let movie = movie else {
                self.viewDelegate?.showError(message: MessageConstants.genericErrorMessage)
                return
            }
            completion(movie)
        }
    }
    
}
