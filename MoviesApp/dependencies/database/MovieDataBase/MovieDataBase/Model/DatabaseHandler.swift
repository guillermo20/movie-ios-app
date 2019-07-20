//
//  DatabaseHandler.swift
//  MovieDataBase
//
//  Created by Guillermo Gutierrez on 7/11/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

public struct DatabaseHandler: Storage {
    
    var dataController: DataController!
    
    public init(dataModelName: DataBaseName) {
        self.dataController = DataController(modelName: dataModelName.rawValue)
    }
    
    public func loadInitConfig() {
        self.dataController.load()
    }
    
    // MARK: Storage protocol functions
    
    public func save() {
        dataController.backgroundContext.perform {
            try? self.dataController.backgroundContext.save()
        }
    }
    
    public func delete(object: DatabaseObject, completion: @escaping () -> Void) {
        dataController.backgroundContext.perform { 
            
        }
        completion()
    }
    
    
    public func fetch<T: DatabaseObject>(type: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: @escaping ([T]?) -> ()) {
        guard let result = dataController.fetchObject(type: type, predicate: predicate!) else {
            return
        }
        completion(result)
    }
    
    
    public func createObject<T: DatabaseObject>(type: T.Type) -> T {
        let result = dataController.createObject(type: type)
        return result
    }
    
    
}
