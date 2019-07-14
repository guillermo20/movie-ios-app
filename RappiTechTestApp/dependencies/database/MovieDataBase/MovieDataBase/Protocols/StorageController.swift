//
//  StorageController.swift
//  MovieDataBase
//
//  Created by Guillermo Gutierrez on 7/13/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

public protocol StorageController {
    
    init(dataModelName: DataBaseName)
    
    func save(object: DatabaseObject, completion: @escaping () -> Void)
    func delete(object: DatabaseObject, completion: @escaping () -> Void)
    func fetch<T: DatabaseObject>(model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> ()))

}
