//
//  DependencyHandler.swift
//  MoviesApp
//
//  Created by Guillermo Gutierrez on 7/19/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation
import MovieWebService
import MovieDataBase
import MovieDBRepository

public class DependencyHandler: Dependency {
    
    
    func resolveService() -> Service {
        return WebServiceClient()
    }
    
    func resolveStorage() -> Storage {
        return DatabaseHandler(dataModelName: .movieDataModel)
    }
    
    func resolveRepository() -> Repository {
        return RepositoryHandler(database: resolveStorage(), service: resolveService())
    }
    
    
}
