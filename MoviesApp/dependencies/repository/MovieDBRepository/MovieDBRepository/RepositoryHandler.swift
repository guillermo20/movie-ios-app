//
//  RepositoryHandler.swift
//  MovieDBRepository
//
//  Created by Guillermo Gutierrez on 7/9/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation
import MovieWebService
import MovieDataBase


class RepositoryHandler: Repository {
    
    let database: StorageController
    
    init(service: WebServiceClient, database: StorageController) {
        self.database = database
    }
    
    func fetchGenres() {
        
    }
    
    public func fetchMovies() {
        
    }
    
    public func fetchTVSeries() {
        
    }
    
    
    
    
}
