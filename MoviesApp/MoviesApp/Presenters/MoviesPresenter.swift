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
    
    func fetchMovieImage(movie: Movie, completion: @escaping (Data?) -> Void) {
        self.repository.fetchMovieImage(movie: movie, imageType: .posterImage) { (data, error) in
            guard let data = data else {
                self.viewDelegate?.showError(message: MessageConstants.genericErrorMessage)
                return
            }
            completion(data)
        }
    }
    
    
//    func fetchMovieImage(movies: [Movie]) {
//        self.repository.fetchMovieImage(movies: [Movie], imageType: .posterImage)
//    }
    
}
