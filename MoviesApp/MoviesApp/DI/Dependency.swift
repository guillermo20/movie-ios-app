//
//  Dependency.swift
//  MoviesApp
//
//  Created by Guillermo Gutierrez on 7/19/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation
import MovieWebService
import MovieDataBase
import MovieDBRepository

protocol Dependency {
    
    func resolveService() -> Service
    func resolveStorage() -> Storage
    func resolveRepository() -> Repository
    
}
