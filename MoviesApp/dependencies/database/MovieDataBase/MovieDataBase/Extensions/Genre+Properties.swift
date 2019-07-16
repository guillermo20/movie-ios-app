//
//  Genre+PublicExtension.swift
//  MovieDataBase
//
//  Created by Guillermo Gutierrez on 7/14/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation
import CoreData


extension Genre {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Genre> {
        return NSFetchRequest<Genre>(entityName: "Genre")
    }
    
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var movies: NSSet?
    @NSManaged public var tvSeries: NSSet?
    
}

// MARK: accessors for movies
extension Genre {
    
    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)
    
    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)
    
    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)
    
    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)
    
}

// MARK: accessors for tvSeries
extension Genre {
    
    @objc(addTvSeriesObject:)
    @NSManaged public func addToTvSeries(_ value: TVSerie)
    
    @objc(removeTvSeriesObject:)
    @NSManaged public func removeFromTvSeries(_ value: TVSerie)
    
    @objc(addTvSeries:)
    @NSManaged public func addToTvSeries(_ values: NSSet)
    
    @objc(removeTvSeries:)
    @NSManaged public func removeFromTvSeries(_ values: NSSet)
    
}
