//
//  GenreEntity.swift
//  MovieDataBase
//
//  Created by Guillermo Gutierrez on 7/11/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

public struct GenreEntity: DatabaseObject {
    
    init(parameters: [String: Any]) {
        self.parameters = parameters
    }
    
    public let parameters: [String: Any]
    
    public var id: Int {
        return self.parameters["id"] as! Int
    }
    
    public var typeName: String {
        return String(describing: Genre.self)
    }
    
    
}
