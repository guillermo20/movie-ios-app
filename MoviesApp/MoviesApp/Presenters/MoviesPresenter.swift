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
    
    // repository 
    
    weak private var viewDelegate: MoviesViewDelegate?
    
    func setViewDelegate(viewDelegate: MoviesViewDelegate) {
        self.viewDelegate = viewDelegate
    }
    
}
