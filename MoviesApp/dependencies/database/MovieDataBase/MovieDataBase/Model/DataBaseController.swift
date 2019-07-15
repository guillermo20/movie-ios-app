//
//  DataBaseController.swift
//  MovieDataBase
//
//  Created by Guillermo Gutierrez on 7/11/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

public class DataBaseController: StorageController {
    
    var dataController: DataController!
    
    required public init(dataModelName: DataBaseName) {
        self.dataController = DataController(modelName: dataModelName.rawValue)
        self.dataController.load()
    }
    
    func commitTransaction() {
        do {
            try self.dataController.backgroundContext.save()
        } catch {
            NSLog("an error has ocurred while saving data", error.localizedDescription)
        }
    }
    
    // MARK: StorageController protocol functions
    
    public func save(object: DatabaseObject, completion: @escaping () -> Void) {
        dataController.backgroundContext.perform { [unowned self] in
            try? self.dataController.backgroundContext.save()
        }
        completion()
    }
    
    public func delete(object: DatabaseObject, completion: @escaping () -> Void) {
        dataController.backgroundContext.perform { [unowned self] in
            
        }
        completion()
    }
    
    
    public func fetch<T: DatabaseObject>(type: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: @escaping ([T]) -> ()) {
        guard let result = dataController.fetchObject(type: type, predicate: predicate!) else {
            return
        }
        completion(result)
    }
    
    
    public func createObject<T: DatabaseObject>(type: T.Type, completion: @escaping (T) -> Void) {
        let result = dataController.createObject(type: type)
        completion(result)
    }
    
    
}
