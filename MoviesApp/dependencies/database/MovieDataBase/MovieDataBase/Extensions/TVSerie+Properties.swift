//
//  TVSerie+PublicExtension.swift
//  MovieDataBase
//
//  Created by Guillermo Gutierrez on 7/14/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation
import CoreData

extension TVSerie {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TVSerie> {
        return NSFetchRequest<TVSerie>(entityName: "TVSerie")
    }
    
    @NSManaged public var backdropPath: String?
    @NSManaged public var firstAirDate: Date?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalName: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int32
    @NSManaged public var genres: NSSet?
    
}

// MARK: Generated accessors for genres
extension TVSerie {
    
    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: Genre)
    
    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: Genre)
    
    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)
    
    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)
    
}
