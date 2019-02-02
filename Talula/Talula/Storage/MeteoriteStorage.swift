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
    
    init(delegate: NSFetchedResultsControllerDelegate) {
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
    
}
