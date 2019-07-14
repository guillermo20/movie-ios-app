//
//  MovieDAO.swift
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
    
    public func save(object: DatabaseObject, completion: @escaping () -> Void) {
        dataController.backgroundContext.perform { [unowned self] in
            self.dataController.createObject(entityObject: object)
            self.commitTransaction()
        }
    }
    
    public func delete(object: DatabaseObject, completion: @escaping () -> Void) {
        dataController.backgroundContext.perform { [unowned self] in
            let managedObject = self.dataController.fetchObject(entityObject: object)
            self.dataController.backgroundContext.delete(managedObject)
        }
    }
    
    public func fetch<T>(model: T.Type, predicate: NSPredicate?,
                         sorted: Sorted?,
                         completion: (([T]) -> ())) where T : DatabaseObject {
        // ToDo: implement this
    }
    
    
}
