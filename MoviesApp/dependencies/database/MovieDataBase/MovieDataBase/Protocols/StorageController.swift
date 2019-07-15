//
//  StorageController.swift
//  MovieDataBase
//
//  Created by Guillermo Gutierrez on 7/13/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

// simple abstraction of an storage or database interace.
public protocol StorageController {
    
    init(dataModelName: DataBaseName)
    
    func createObject<T: DatabaseObject>(type: T.Type, completion: @escaping (T) -> Void )
    func save(object: DatabaseObject, completion: @escaping () -> Void)
    func delete(object: DatabaseObject, completion: @escaping () -> Void)
    func fetch<T: DatabaseObject>(type: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: @escaping ([T]) -> ())

}
