//
//  DataController.swift
//  MovieDataBase
//
//  Created by Guillermo Gutierrez on 7/9/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    let persistentContainer: NSPersistentContainer
    
    var viewContext:NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    let backgroundContext:NSManagedObjectContext!
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: "MovieDataModel")
        
        backgroundContext = persistentContainer.newBackgroundContext()
    }
    
    func configureContexts() {
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
        
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            self.configureContexts()
            completion?()
        }
    }
    
    // MARK: Helper Functions
    func createObject(entityObject: DatabaseObject) -> NSManagedObject{
        
        
        let entity = NSEntityDescription.entity(forEntityName: entityObject.typeName,
                                                in: backgroundContext)!
        
        let object = NSManagedObject(entity: entity, insertInto: backgroundContext)
        
        for (key, value) in entityObject.parameters {
            object.setValue(value, forKey: key)
        }
        
        return object
    }
    
    func fetchObject(entityObject: DatabaseObject) -> NSManagedObject {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityObject.typeName)
        request.predicate = NSPredicate(format: "id = %@", entityObject.id)
        let result = try? self.backgroundContext.fetch(request)
        return result?[0] as! NSManagedObject
    }
}
