//
//  MoviesPresenter.swift
//  MoviesApp
//
//  Created by Guillermo Gutierrez on 7/18/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation
import MovieDBRepository

class MoviesPresenter {
    
    let repository: Repository
    
    weak private var viewDelegate: MoviesViewDelegate?
    
    init(viewDelegate: MoviesViewDelegate, repository: Repository) {
        self.viewDelegate = viewDelegate
        self.repository = repository
    }
    
}
