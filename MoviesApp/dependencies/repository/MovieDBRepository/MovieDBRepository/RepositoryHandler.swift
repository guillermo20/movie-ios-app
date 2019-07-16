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

/// repository handler. serves as a separator of the module layers.
/// this separates the ui layer from the data layer,
/// all ui calls should have been abstracted meaning that repository
/// handles all the complex logic from retreiving data from remote api
/// to saving it into the local store
class RepositoryHandler: Repository {
    
    let database: StorageController
    
    init(service: WebServiceClient, database: StorageController) {
        self.database = database
    }
    
    func loadGenres(completion: @escaping (Genre?, Error?) -> Void) {
        
        // verifies that the app has internet conectivity
        if !WebServiceClient.isConnectedToInternet() {
            completion(nil, MoviesError(message: "app could not connect to internet"))
            return
        }
        
        // loads data from the remote api
        WebServiceClient.loadData(byCategory: GenreEndpoint.tvGenreList
        ,withResponseType: GenreResponse.self) { (response, error) in
            guard let response = response else {
                completion(nil, error)
                return
            }
            
            for genreItem in response.genres {
                
                self.database.createObject(type: Genre.self, completion: { (object) in
                    object.id = Int32(genreItem.id)
                    object.name = genreItem.name
                    self.database.save(object: object, completion: {
                        //do nothing
                    })
                })
                
            }
            
            
            
        }
    }
    
    public func fetchMovies() {
        
    }
    
    public func fetchTVSeries() {
        
    }
    
}
