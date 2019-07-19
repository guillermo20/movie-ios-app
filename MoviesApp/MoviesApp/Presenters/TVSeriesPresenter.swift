//
//  TVSeriesPresenter.swift
//  MoviesApp
//
//  Created by Guillermo Gutierrez on 7/18/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation
import MovieDBRepository

class TVSeriesPresenter {
    
    let repository: Repository
    
    weak private var viewDelegate: TVSeriesViewDelegate?
    
    init(viewDelegate: TVSeriesViewDelegate, repository: Repository) {
        self.viewDelegate = viewDelegate
        self.repository = repository
    }
    
}
