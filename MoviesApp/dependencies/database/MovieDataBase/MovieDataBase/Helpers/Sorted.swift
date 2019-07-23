//
//  Sorted.swift
//  MovieDataBase
//
//  Created by Guillermo Gutierrez on 7/13/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

public struct Sorted {
    
    public init(key: String, ascending: Bool) {
        self.key = key
        self.ascending = ascending
    }
    let key: String
    let ascending: Bool
}
