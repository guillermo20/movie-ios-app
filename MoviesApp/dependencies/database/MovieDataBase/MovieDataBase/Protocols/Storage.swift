//
//  Storage.swift
//  MovieDataBase
//
//  Created by Guillermo Gutierrez on 7/13/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

// simple abstraction of an storage or database interface.
public protocol Storage {
    
    init(dataModelName: DataBaseName)
    
    func loadInitConfig()
    func createObject<T: DatabaseObject>(type: T.Type) -> T
    func save()
    func delete(object: DatabaseObject, completion: @escaping () -> Void)
    func fetch<T: DatabaseObject>(type: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: @escaping ([T]?) -> ())

}
