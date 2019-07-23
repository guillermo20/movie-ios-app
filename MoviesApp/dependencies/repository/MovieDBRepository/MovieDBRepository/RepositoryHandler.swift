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
/// and saving it into the local store
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
    
    public func fetchMovies(pageNumber: Int = 1, completion: @escaping ([Movie]?, Error?) -> Void) {
        let parameters = ParameterBuilder().pageNumber(page: pageNumber).build()
        if service.isConnectedToInternet() {
            service.loadData(byCategory: MovieEndpoint.topRated, withResponseType: MoviesResponse.self, withParameters: parameters) { (response, error) in
                guard let results = response?.results else {
                    NSLog(error!.localizedDescription)
                    self.fetchMoviesFromDatabase(pageNumber: pageNumber, completion: completion)
                    return
                }
                for item in results {
                    //need to build the NSpredicate here
                    NSLog(item.title)
                    let predicate = NSPredicate(format: "id == %ld", item.id)
                    self.database.fetch(type: Movie.self, predicate: predicate, sorted: nil, completion: { (movieList) in
                        if let movie = movieList?.first {
                            NSLog("title = %@ , id = %ld", movie.title!, movie.id)
                        } else {
                            let movieObj = self.database.createObject(type: Movie.self)
                            movieObj.backdropPath = item.backdropPath
                            movieObj.posterPath = item.posterPath
                            movieObj.title = item.title
                            movieObj.id = Int32(item.id)
                            movieObj.originalTitle = item.originalTitle
                            movieObj.pageNumber = Int32(pageNumber)
                            // todo: genres IDs
                            // todo: movieObj.releaseDate = Date(item.releaseDate
                            
                            
                        }
                    })
                }
                self.database.save()
                self.fetchMoviesFromDatabase(pageNumber: pageNumber, completion: completion)
            }
        } else {
            self.fetchMoviesFromDatabase(pageNumber: pageNumber, completion: completion)
        }
    }
    
    private func fetchMoviesFromDatabase(pageNumber: Int, completion: @escaping ([Movie]?, Error?) -> Void) {
        let predicate = NSPredicate(format: "pageNumber == %@", String(pageNumber))
        database.fetch(type: Movie.self, predicate: predicate, sorted: Sorted(key: "creationDate", ascending: true)) { (movieList) in
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
    
    public func fetchMovieImage(movie: Movie, imageType: ImageType, completion: @escaping(Data?, Error?) -> Void) {
        guard let filePath = movie.posterPath else {
            return
        }
        
        var endpoint: Endpoint?
        switch imageType {
        case .backdropImage:
            endpoint = ImageEndpoint.defaultBackdropURL(filePath)
            break
        case .posterImage:
            endpoint = ImageEndpoint.defaultPosterURL(filePath)
            break
        }
        
        service.donwloadData(byCategory: endpoint!) { (data, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(data, nil)
            }
            self.database.save()
        }
    }
    
}
