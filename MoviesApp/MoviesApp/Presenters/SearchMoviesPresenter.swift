//
//  SearchMoviesPresenter.swift
//  MoviesApp
//
//  Created by Guillermo Gutierrez on 7/29/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation
import MovieDBRepository
import MovieDataBase

class SearchMoviesPresenter {
    
    let repository: Repository
    
    var viewDelegate: SearchMoviesViewDelegate?
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func setViewDelegate(viewDelegate: SearchMoviesViewDelegate) {
        self.viewDelegate = viewDelegate
    }
    
    func fetchMovies(byName: String? = nil) {
        repository.fetchAllMovies { (moviesList, error) in
            guard let moviesList = moviesList else {
                self.viewDelegate?.showError(message: error!.localizedDescription)
                return
            }
            guard let filter = byName else {
                 self.viewDelegate?.displayMovies(movies: moviesList)
                return
            }
            let filteredMovies = moviesList.filter({ (movie) -> Bool in
                (movie.title?.lowercased().contains(filter.lowercased()))!
            })
            self.viewDelegate?.displayMovies(movies: filteredMovies)
        }
        
    }
}
