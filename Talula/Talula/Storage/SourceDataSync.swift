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
    
    func fetchMeteorites(completion: @escaping(Error?) -> Void) {
        downloader.getMeteorites() { dataDictionary, error in
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
            
            let matchingMeteoriteRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Meteorite")
            let meteoriteIds = dataDictionary.map { $0["id"] as? String }.compactMap { $0 }
            matchingMeteoriteRequest.predicate = NSPredicate(format: "meteoriteId in %@", argumentArray: [meteoriteIds])
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: matchingMeteoriteRequest) // batch delete and merge
            batchDeleteRequest.resultType = .resultTypeObjectIDs
            
            do {
                let batchDeleteResult = try context.execute(batchDeleteRequest) as? NSBatchDeleteResult
                
                if let deletedObjectIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedObjectIDs], into: [self.persistentContainer.viewContext]) //merge (updates)
                }
            } catch let error as NSError {
                print("Batch delete error: \(error.debugDescription).")
                return
            }
            
            for meteoriteDictionary in dataDictionary { //new data
                
                guard
                    let meteorite = NSEntityDescription.insertNewObject(forEntityName: "Meteorite", into: context) as? Meteorite // new objects
                else {
                    print("Insert error: Failed to create new object.")
                    return
                }
                
                do {
                    try meteorite.update(with: meteoriteDictionary) //set properties
                } catch let error as NSError{
                    print("Update error: \(error.debugDescription).")
                    context.delete(meteorite)
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
}
