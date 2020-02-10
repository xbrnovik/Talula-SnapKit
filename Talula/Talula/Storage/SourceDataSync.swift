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
    
    // MARK: - Init
    
    init() {
        self.persistentContainer = CoreDataContainer.shared.persistentContainer
        self.downloader = SourceDataDownloader()
    }
    
    // MARK: - Fetch
    
    /**
     1. Checks if data are obtained.
     2. Updates persistent data by private function.
     3. Sends error message if necessary.
     
     
     - Parameter all: Information saying if all data is neccessary to download.
     */
    func fetchMeteorites(all: Bool, completion: @escaping(Error?) -> Void) {
        downloader.getMeteorites(all: all) { dataDictionary, error in
            // Checks if is error a result, if true then returns.
            if let error = error {
                completion(error)
                return
            }
            // Checks if data are obtained.
            guard let dataDictionary = dataDictionary else {
                let error = NSError(domain: Constants.error.dataDomain, code: Constants.error.incorrectDataFormat, userInfo: nil)
                completion(error)
                return
            }
            // Sets new context - backgroung contect works for both (foreground, backgroung).
            let context = self.persistentContainer.newBackgroundContext()
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            context.undoManager = nil
            // Updates persistent data.
            let accepted = self.syncMeteorites(dataDictionary: dataDictionary, context: context)
            // If update was not successful returns error.
            if accepted {
                completion(nil)
            } else {
                let error = NSError(domain: Constants.error.dataDomain, code: Constants.error.syncFailure, userInfo: nil)
                completion(error)
            }
            
        }
    }
    
    /**
     Saves new meteorites and updates old meteorites using MeteoriteStorage class.
     
     - Parameters:
            - dataDictionary: Dictionary of obtained data.
            - context: Context which updates persistent data.
     
     - Returns: Information about success of update in persistent storage.
     */
    private func syncMeteorites(dataDictionary: [[String: Any]], context: NSManagedObjectContext) -> Bool {
        var successfull = false
        let storage = MeteoriteStorage()
        storage.setExternalContext(context: context)
        // Performs update.
        context.performAndWait {
            // Loops on meteorites.
            for meteoriteDictionary in dataDictionary { //new data
                // Meteorite definition.
                let meteorite: Meteorite?
                let id = meteoriteDictionary["id"] as! String
                // Gets meteorite.
                if let meteoriteObject = storage.getById(id: id) {
                    // Gets existing object.
                    meteorite = meteoriteObject
                } else {
                    // Creates a new object.
                    meteorite = storage.create()
                }
                // Saves updates.
                do {
                    try meteorite?.update(with: meteoriteDictionary) //set properties
                } catch let error as NSError{
                    NSLog("Update error: \(error.debugDescription).")
                    context.delete(meteorite!)
                }
               
            }
            // Context saves all changes.
            storage.save()
            successfull = true
        }
        return successfull
    }
    
}
