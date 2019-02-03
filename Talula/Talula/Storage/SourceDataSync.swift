//
//  SourceDataSync.swift
//  Talula
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import CoreData

class SourceDataSync {
    
    private let persistentContainer: NSPersistentContainer
    private let downloader: SourceDataDownloader
    
    init() {
        self.persistentContainer = CoreDataContainer.shared.persistentContainer
        self.downloader = SourceDataDownloader()
    }
    
    func fetchMeteorites(all:Bool, completion: @escaping(Error?) -> Void) {
        downloader.getMeteorites(all: all) { dataDictionary, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard
                let dataDictionary = dataDictionary
            else {
                let error = NSError(domain: Constants.error.dataDomain, code: Constants.error.incorrectDataFormat, userInfo: nil)
                completion(error)
                return
            }
            
            let context = self.persistentContainer.newBackgroundContext()
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            context.undoManager = nil
            
            let accepted = self.syncMeteorites(dataDictionary: dataDictionary, context: context)
            
            if accepted {
                completion(nil)
            } else {
                let error = NSError(domain: Constants.error.dataDomain, code: Constants.error.syncFailure, userInfo: nil)
                completion(error)
            }
            
        }
    }
    
    private func syncMeteorites(dataDictionary: [[String: Any]], context: NSManagedObjectContext) -> Bool {
        var successfull = false
        context.performAndWait {
            
            //let meteoriteIds = dataDictionary.map { $0["id"] as? String }.compactMap { $0 }
            //matchingMeteoriteRequest.predicate = NSPredicate(format: "meteoriteId in %@", argumentArray: [meteoriteIds])
            
            for meteoriteDictionary in dataDictionary { //new data
                
                let meteorite: Meteorite?
                let id = meteoriteDictionary["id"] as! String
                
                if let meteoriteObject = self.getById(context: context, id: id) {
                    //old
                    meteorite = meteoriteObject
                } else {
                    //new
                    meteorite = NSEntityDescription.insertNewObject(forEntityName: "Meteorite", into: context) as? Meteorite // new objects
                }
                
                do {
                    try meteorite!.update(with: meteoriteDictionary) //set properties
                } catch let error as NSError{
                    print("Update error: \(error.debugDescription).")
                    context.delete(meteorite!)
                }
                
                
            }
            
            if context.hasChanges {
                do {
                    try context.save() //save changes
                } catch let error as NSError {
                    print("Save error: \(error.debugDescription).")
                }
                context.reset() // free cache
            }
            successfull = true
        }
        return successfull
    }
    
    
    func getById(context: NSManagedObjectContext, id: String) -> Meteorite? {
        let matchingMeteoriteRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.coreData.entityName)
        matchingMeteoriteRequest.predicate = NSPredicate(format: "meteoriteId = %@", id)
        matchingMeteoriteRequest.sortDescriptors = [NSSortDescriptor(key: Constants.coreData.defaultDescriptorPropertyName, ascending: false)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: matchingMeteoriteRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Fetch error: \(error)")
            abort()
        }
        return fetchedResultsController.fetchedObjects?.first as? Meteorite
    }
}
