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
public class RepositoryHandler: Repository {
    
    let database: StorageController
    
    public init(database: StorageController) {
        self.database = database
    }
    
    public func loadInitConfig() {
        self.database.loadInitConfig()
    }
    
    func loadGenres(completion: @escaping ([Genre]?, Error?) -> Void) {
        
        // verifies that the app has internet conectivity
        if !WebServiceClient.isConnectedToInternet() {
            DispatchQueue.main.async {
                completion(nil, MoviesError(message: "app could not connect to internet"))
            }
            return
        }
        
        // loads data from the remote api tv series genres
        WebServiceClient.loadData(byCategory: GenreEndpoint.tvGenreList
        ,withResponseType: GenreResponse.self) { (response, error) in
            guard let responseTV = response else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            // loads data from the remote api tv series genres
            WebServiceClient.loadData(byCategory: GenreEndpoint.moviesGenreList
                , withResponseType: GenreResponse.self, completion: { (response, error) in
                    guard let responseMovie = response else {
                        DispatchQueue.main.async {
                            completion(nil, error)
                        }
                        return
                    }
                    var generes = responseTV.genres
                    generes.append(contentsOf: responseMovie.genres)
                    NSLog("genre tv series items = %i", generes.count)
            })
        }
    }
    
    public func fetchMovies() {
        
    }
    
    public func fetchTVSeries() {
        
    }
    
}
