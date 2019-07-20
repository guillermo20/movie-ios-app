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
    
    func fetchMovies(completion: @escaping (Movie, Error) -> Void) {
        
    }
    
}
