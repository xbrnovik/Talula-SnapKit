//
//  MeteoriteStorage.swift
//  Talula
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import CoreData

class MeteoriteStorage {
    
    internal var fetchedResultsController: NSFetchedResultsController<Meteorite>
    internal var managedObjectContext: NSManagedObjectContext
    
    init(_ delegate: NSFetchedResultsControllerDelegate? = nil) {
        self.managedObjectContext = CoreDataContainer.shared.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Meteorite> = NSFetchRequest()
        let entity = NSEntityDescription.entity(forEntityName: Constants.coreData.entityName, in: self.managedObjectContext)
        fetchRequest.entity = entity
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: Constants.coreData.defaultDescriptorPropertyName, ascending: false)]
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = delegate
        do {
            try aFetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Fetch error: \(error.debugDescription)")
            abort()
        }
        
        self.fetchedResultsController = aFetchedResultsController
    }
    
    func setExternalContext(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }
    
    func getById(id: String) -> Meteorite? {
        let matchingMeteoriteRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.coreData.entityName)
        matchingMeteoriteRequest.predicate = NSPredicate(format: "meteoriteId = %@", id)
        matchingMeteoriteRequest.sortDescriptors = [NSSortDescriptor(key: Constants.coreData.defaultDescriptorPropertyName, ascending: false)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: matchingMeteoriteRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Fetch error: \(error)")
            abort()
        }
        return fetchedResultsController.fetchedObjects?.first as? Meteorite
    }
    
    func create() -> Meteorite? {
        return NSEntityDescription.insertNewObject(forEntityName: Constants.coreData.entityName, into: managedObjectContext) as? Meteorite // new objects
    }
    
    func save() {
        if managedObjectContext.hasChanges {
            do {
                // Saves changes.
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Save error: \(error.debugDescription).")
            }
            // Frees cache.
            managedObjectContext.reset()
        }
    }
    
}
