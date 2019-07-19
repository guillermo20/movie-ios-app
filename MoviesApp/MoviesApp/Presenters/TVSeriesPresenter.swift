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
    
    // repository
    
    weak private var viewDelegate: TVSeriesViewDelegate?
    
    func setViewDelegate(viewDelegate: TVSeriesViewDelegate) {
        self.viewDelegate = viewDelegate
    }
    
}
