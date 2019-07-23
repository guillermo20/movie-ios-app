//
//  Movie+Extension.swift
//  MovieDataBase
//
//  Created by Guillermo Gutierrez on 7/22/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation
import CoreData

public extension Movie {
    override func awakeFromInsert() {
        super.awakeFromInsert()
        creationDate = Date()
    }
}
