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
    
    // initializes initial configuration of the storage
    func loadInitConfig()
    
    // creates a simple object
    func createObject<T: DatabaseObject>(type: T.Type, completion: @escaping(T) -> Void)
    
    // saves data into the store. the completion handler is called after the save process is finished
    func save(completion: (() -> Void)?)
    
    func delete(object: DatabaseObject, completion: @escaping () -> Void)
    
    // fetch objects based on a predicate and a sorting criteria.
    func fetch<T: DatabaseObject>(type: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: @escaping ([T]?) -> ())

}

public extension Storage {
    func save(completion: (() -> Void)? = nil) {
        save(completion: completion)
    }
}
