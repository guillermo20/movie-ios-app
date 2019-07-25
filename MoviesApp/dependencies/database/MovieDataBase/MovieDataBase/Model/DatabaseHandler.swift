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
            if self.dataController.backgroundContext.hasChanges {
                try? self.dataController.backgroundContext.save()
            }
        }
        dataController.viewContext.perform {
            if self.dataController.viewContext.hasChanges {
                try? self.dataController.viewContext.save()
            }
        }
    }
    
    public func delete(object: DatabaseObject, completion: @escaping () -> Void) {
        dataController.backgroundContext.perform { 
            
        }
        completion()
    }
    
    
    public func fetch<T: DatabaseObject>(type: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: @escaping ([T]?) -> ()) {
        guard let result = self.dataController.fetchObject(type: type, predicate: predicate, sorted: sorted) else {
            return
        }
        completion(result)
    }
    
    
    public func createObject<T: DatabaseObject>(type: T.Type, completion: @escaping(T) -> Void) {
        dataController.backgroundContext.perform {
            let result = self.dataController.createObject(type: type)
            completion(result)
        }
    }
    
    
}
