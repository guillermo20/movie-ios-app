//
//  GenreBuilder.swift
//  MovieDataBase
//
//  Created by Guillermo Gutierrez on 7/11/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

public class GenreBuilder {
    
    private var parameters: [String: Any]
    
    init() {
        parameters =  [String: Any]()
    }
    
    public func withId(id: Int) -> GenreBuilder {
        parameters["id"] = id
        return self
    }
    
    public func withName(name: String) -> GenreBuilder {
        parameters["name"] = name
        return self
    }
    
    public func build() -> GenreEntity {
        return GenreEntity(parameters: self.parameters)
    }
}
