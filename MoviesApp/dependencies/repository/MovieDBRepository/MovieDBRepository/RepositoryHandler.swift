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
public struct RepositoryHandler: Repository {
    
    private let database: Storage
    
    private let service: Service
    
    public init(database: Storage, service: Service) {
        self.database = database
        self.service = service
        self.database.loadInitConfig()
    }
    
    func loadGenres(completion: @escaping ([Genre]?, Error?) -> Void) {
        
        // verifies that the app has internet conectivity
        if !service.isConnectedToInternet() {
            DispatchQueue.main.async {
                completion(nil, MoviesError(message: "app could not connect to internet"))
            }
            return
        }
        
        // loads data from the remote api tv series genres
        service.loadData(byCategory: GenreEndpoint.tvGenreList
        ,withResponseType: GenreResponse.self) { (response, error) in
            guard let responseTV = response else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            // loads data from the remote api tv series genres
            self.service.loadData(byCategory: GenreEndpoint.moviesGenreList
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
    
    public func fetchMovies(completion: @escaping ([Movie]?, Error?) -> Void) {
        NSLog("calls the fetchMovie implementation")
        if service.isConnectedToInternet() {
            service.loadData(byCategory: MovieEndpoint.topRated, withResponseType: MoviesResponse.self) { (response, error) in
                guard let results = response?.results else {
                    NSLog(error!.localizedDescription)
                    self.fetchMoviesFromDatabase(completion: completion)
                    return
                }
                
                var movieList = [Movie]()
                for item in results {
                    let movieObj = self.database.createObject(type: Movie.self)
                    movieObj.backdropPath = item.backdropPath
                    movieObj.posterPath = item.posterPath
                    movieObj.title = item.title
                    movieObj.id = Int32(item.id)
                    movieObj.originalTitle = item.originalTitle
                    // genres IDs
                    // movieObj.releaseDate = Date(item.releaseDate
                    movieList.append(movieObj)
                }
                self.database.save()
                DispatchQueue.main.async {
                    completion(movieList, nil)
                }
            }
        } else {
            self.fetchMoviesFromDatabase(completion: completion)
        }
    }
    
    private func fetchMoviesFromDatabase(completion: @escaping ([Movie]?, Error?) -> Void) {
        database.fetch(type: Movie.self, predicate: nil, sorted: nil) { (movieList) in
            guard let movieList = movieList else {
                DispatchQueue.main.async {
                    completion(nil, MoviesError(message: "could not retrieve data from local store."))
                }
                return
            }
            DispatchQueue.main.async {
                completion(movieList, nil)
            }
        }
    }
    
    public func fetchMoviePosterImage(movie: Movie, completion: @escaping(Data?, Error) -> Void) {
        guard let filePath = movie.posterPath else {
            return
        }
        
        service.donwloadData(byCategory: ImageEndpoint.defaultPosterURL(filePath)) { (data, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    //completion(nil, error)
                }
                return
            }
            movie.posterImage = data
            
            //saves the change in the NSManagedOject in the db
            self.database.save()
            
            DispatchQueue.main.async {
                //completion(data, error)
            }
        }
    }
    
    public func fetchTVSeries() {
        
    }
    
}
