//
//  Movie+PublicExtension.swift
//  MovieDataBase
//
//  Created by Guillermo Gutierrez on 7/14/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation
import CoreData

extension Movie {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }
    
    @NSManaged public var adult: Bool
    @NSManaged public var backdropPath: String?
    @NSManaged public var id: Int32
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var video: Bool
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int32
    @NSManaged public var genres: NSSet?
    
}

// MARK: accessors for genres
extension Movie {
    
    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: Genre)
    
    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: Genre)
    
    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)
    
    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)
    
}
