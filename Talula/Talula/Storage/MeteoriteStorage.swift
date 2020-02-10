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
    
    // MARK: - Init
    
    init(_ delegate: NSFetchedResultsControllerDelegate? = nil) {
        self.managedObjectContext = CoreDataContainer.shared.persistentContainer.viewContext
        // To fill cache is necessary first of all get saved data.
        let fetchRequest: NSFetchRequest<Meteorite> = NSFetchRequest()
        let entity = NSEntityDescription.entity(forEntityName: Constants.coreData.entityName, in: self.managedObjectContext)
        fetchRequest.entity = entity
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: Constants.coreData.defaultDescriptorPropertyName, ascending: false)]
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = delegate
        do {
            try aFetchedResultsController.performFetch()
        } catch let error as NSError {
            NSLog("Fetch error: \(error.debugDescription)")
            abort()
        }
        //Set fetchedResultController with cached data.
        self.fetchedResultsController = aFetchedResultsController
    }
    
    // MARK: - Setter
    
    /**
     Saves external context to storage.
     
     For example, this is used for bacground fetch of data.
     
     - Parameter context: User new NSManagedObjectContext.
     */
    func setExternalContext(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }
    
    // MARK: - Operations on storage
    
    /**
     Gets meteorite object by its meteoriteId.
     
     - Parameter id: The meteoriteId of searched meteorite object.
     
     - Returns: Meteorite object with given id.
     */
    func getById(id: String) -> Meteorite? {
        let matchingMeteoriteRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.coreData.entityName)
        matchingMeteoriteRequest.predicate = NSPredicate(format: "meteoriteId = %@", id)
        matchingMeteoriteRequest.sortDescriptors = [NSSortDescriptor(key: Constants.coreData.defaultDescriptorPropertyName, ascending: false)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: matchingMeteoriteRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            NSLog("Fetch error: \(error)")
            abort()
        }
        return fetchedResultsController.fetchedObjects?.first as? Meteorite
    }
    
    /**
     Creates new meteorite object.
     
     - Returns: A new meteorite object.
     */
    func create() -> Meteorite? {
        return NSEntityDescription.insertNewObject(forEntityName: Constants.coreData.entityName, into: managedObjectContext) as? Meteorite // new objects
    }
    
    /// Saves changes to managed object context.
    func save() {
        if managedObjectContext.hasChanges {
            do {
                // Saves changes.
                try managedObjectContext.save()
            } catch let error as NSError {
                NSLog("Save error: \(error.debugDescription).")
            }
            // Frees cache.
            managedObjectContext.reset()
        }
    }
    
}
