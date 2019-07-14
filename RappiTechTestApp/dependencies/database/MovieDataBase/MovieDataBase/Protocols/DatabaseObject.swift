//
//  DatabaseObject.swift
//  MovieDataBase
//
//  Created by Guillermo Gutierrez on 7/13/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation
import CoreData

public protocol DatabaseObject {
    var id: Int { get }
    var parameters: [String: Any] { get }
    var typeName: String { get }
}
