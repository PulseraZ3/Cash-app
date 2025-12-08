//
//  PersistenceController.swift
//  CashControl
//
//  Created by LEONARDO FAVIO  on 7/12/25.
//

import CoreData

struct PersistenceController{
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    var context: NSManagedObjectContext{
        container.viewContext
    }
    init(){
        container = NSPersistentContainer(name: "CashControl")
        // migracion automatica
        let description = container.persistentStoreDescriptions.first
        description?.setOption(true as NSNumber, forKey: NSMigratePersistentStoresAutomaticallyOption)
        description?.setOption(true as NSNumber, forKey: NSInferMappingModelAutomaticallyOption)
        
        container.loadPersistentStores{_,error in
            if let error = error as NSError? {
                fatalError("Error en coredata: \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
