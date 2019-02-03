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
        let storage = MeteoriteStorage()
        storage.setExternalContext(context: context)
        
        context.performAndWait {
            
            for meteoriteDictionary in dataDictionary { //new data
                
                let meteorite: Meteorite?
                let id = meteoriteDictionary["id"] as! String
                
                if let meteoriteObject = storage.getById(id: id) {
                    // existing object
                    meteorite = meteoriteObject
                } else {
                    //new object
                    meteorite = storage.create()
                }
                
                do {
                    try meteorite?.update(with: meteoriteDictionary) //set properties
                } catch let error as NSError{
                    print("Update error: \(error.debugDescription).")
                    context.delete(meteorite!)
                }
               
            }
            
            storage.save()
            successfull = true
        }
        return successfull
    }
    
    
    
}
