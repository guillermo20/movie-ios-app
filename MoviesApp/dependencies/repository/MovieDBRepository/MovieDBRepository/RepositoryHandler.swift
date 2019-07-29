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
/// all ui calls have been abstracted meaning that repository
/// handles all the complex logic like retreiving data from remote api
/// and saving it into the local store
public class RepositoryHandler: Repository {
    
    private let database: Storage
    
    private let service: Service
    
    public init(database: Storage, service: Service) {
        self.database = database
        self.service = service
        self.database.loadInitConfig()
        NotificationCenter.default.addObserver(self
            , selector: #selector(appEnteredBackground)
            , name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    private func fetchMovies(pageNumber: Int, category: Endpoint, completion: @escaping ([Movie]?, Error?) -> Void) {
        let parameters = ParameterBuilder().pageNumber(page: pageNumber).build()
        if service.isConnectedToInternet() {
            service.loadData(byCategory: category, withResponseType: MoviesResponse.self, withParameters: parameters) { (response, error) in
                guard let results = response?.results else {
                    NSLog(error!.localizedDescription)
                    self.fetchMoviesFromDatabase(pageNumber: pageNumber, category: category.categoryDescription, completion: completion)
                    return
                }
                for remoteMovie in results {
                    let predicate = NSPredicate(format: "id == %ld", remoteMovie.id)
                    self.database.fetch(type: Movie.self, predicate: predicate, sorted: nil, completion: { [unowned self] (movieList) in
                        if let movie = movieList?.first {
                            NSLog("title = %@ , id = %ld, pagenumber = %ld", movie.title!, movie.id, pageNumber)
                            movie.category = category.categoryDescription
                            movie.creationDate = Date()
                        } else {
                            self.database.createObject(type: Movie.self) { movieObj in
                                movieObj.category = category.categoryDescription
                                movieObj.backdropPath = remoteMovie.backdropPath
                                movieObj.posterPath = remoteMovie.posterPath
                                movieObj.title = remoteMovie.title
                                movieObj.id = Int32(remoteMovie.id)
                                movieObj.originalTitle = remoteMovie.originalTitle
                                movieObj.overview = remoteMovie.overview
                                movieObj.pageNumber = Int32(pageNumber)
                                movieObj.popularity = remoteMovie.popularity
                                movieObj.voteAverage = remoteMovie.voteAverage
                                movieObj.releaseDate = remoteMovie.releaseDate.toDate()
                            }
                        }
                    })
                }
                self.database.save() {
                    self.fetchMoviesFromDatabase(pageNumber: pageNumber,category: category.categoryDescription, completion: completion)
                }
            }
        } else {
            self.fetchMoviesFromDatabase(pageNumber: pageNumber,category: category.categoryDescription, completion: completion)
        }
    }
    
    private func fetchMoviesFromDatabase(pageNumber: Int,category: String ,completion: @escaping ([Movie]?, Error?) -> Void) {
        let predicate = NSPredicate(format: "(pageNumber == %@) AND (category == %@)", String(pageNumber), category)
        database.fetch(type: Movie.self, predicate: predicate, sorted: Sorted(key: "creationDate", ascending: true)) { (movieList) in
            guard let movieList = movieList else {
                DispatchQueue.main.async {
                    completion(nil, MoviesError(message: "could not retrieve data from local store."))
                }
                return
            }
            let movies = movieList.filter({ (movie) -> Bool in
                movie.posterPath != nil
            })
            DispatchQueue.main.async {
                completion(movies, nil)
            }
        }
    }
    
    public func fetchMovieImage(movie: Movie, imageType: ImageType, completion: @escaping(Movie?, Error?) -> Void) {
        var filepath: String?
        var endpoint: Endpoint?
        switch imageType {
        case .backdropImage:
            filepath = movie.backdropPath
            guard let filepath = filepath else {
                completion(nil, MoviesError(message: "could not retrieve image data"))
                return
            }
            endpoint = ImageEndpoint.defaultBackdropURL(filepath)
            break
        case .posterImage:
            filepath = movie.posterPath
            guard let filepath = filepath else {
                completion(nil, MoviesError(message: "could not retrieve image data"))
                return
            }
            endpoint = ImageEndpoint.defaultPosterURL(filepath)
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
                switch imageType {
                case .backdropImage:
                    movie.backdropImage = data
                    break
                case .posterImage:
                    movie.posterImage = data
                    break
                }
                self.database.save() {
                    completion(movie, nil)
                }
            }
        }
    }
    
    
    public func fetchTopRatedMovies(pageNumber: Int, completion: @escaping ([Movie]?, Error?) -> Void) {
        fetchMovies(pageNumber: pageNumber, category: MovieEndpoint.topRated, completion: completion)
    }
    public func fetchPopularMovies(pageNumber: Int, completion: @escaping ([Movie]?, Error?) -> Void) {
        fetchMovies(pageNumber: pageNumber, category: MovieEndpoint.popular, completion: completion)
    }
    public func fetchUpcomingMovies(pageNumber: Int, completion: @escaping ([Movie]?, Error?) -> Void) {
        fetchMovies(pageNumber: pageNumber, category: MovieEndpoint.upcoming, completion: completion)
    }
    
    public func fetchAllMovies(completion: @escaping ([Movie]?, Error?) -> Void) {
        database.fetch(type: Movie.self, predicate: nil, sorted: Sorted(key: "creationDate", ascending: true)) { (movieList) in
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
    
    // todo: this responsibility should be handled on db not on repository abstraction
    @objc private func appEnteredBackground() {
        NSLog("entered appEnteredBackground")
        self.database.save()
    }
    
}
