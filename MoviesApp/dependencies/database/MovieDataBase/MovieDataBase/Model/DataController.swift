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
        guard let modelURL = Bundle(for: type(of: self)).url(forResource: modelName, withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        persistentContainer = NSPersistentContainer(name: modelName, managedObjectModel: mom)
        
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
    
    //creates an empty NSManagedObject given the type passed through the parameter
    func createObject<T: DatabaseObject>(type: T.Type) -> T{
        
        let entity = NSEntityDescription.entity(forEntityName: String(describing: T.self),
                                                in: backgroundContext)!
        
        let object = NSManagedObject(entity: entity, insertInto: backgroundContext)
        return object as! T
    }
    
    func fetchObject<T: DatabaseObject>(type: T.Type, predicate: NSPredicate) -> [T]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: type.self))
        request.predicate = predicate
        //todo: fix this try?
        let result = try? self.backgroundContext.fetch(request)
        return result as! [T]
    }
}
