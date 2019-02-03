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
    
    
    // Pozn pre iOS Lead: Vo vypracovaní nepredpokládam, že by padnuté meteority mohli "odpadnúť/odletieť naspäť". Aktuálne aplikácia ako prvé stiahne všetky záznamy o meteoritoch padnutých po roku 2011. Následne už sťahuje iba tie záznamy databáze, ktorých úprava (aj pridanie) je novšie ako posledná vykonaná aktualizácia. Vďaka tomu aplikácia periodicky sťahuje menšie množstvo dát.
    // V prípade, žeby sme uvažovali aj možný výmaz z databáze mi napadajú dve možné implementačné riešenia.
    // 1) Sťahovali by sa vždy všetky záznamy padnutých meteoritov po roku 2011. Následne by sa našlo "id" tých meteoritov, ktoré sa nachádzajú v Core Datach a nie v zdrojovom JSONe - tieto entity by boli vymazané. Ďalej by pracovala aplikácia rovnako ako teraz, t.j. existujúce záznamy na základe "id" by aktualizovala, neexistujúce vytvorila.
    //2) Sťahovali by sa 2x JSON súbory. Prvý by bol to isté riešenie čo teraz. Druhý by obsahoval čisto "id" hodnoty všetkých meteoritov padnutých po roku 2011. Tieto "id" hodnoty by boli porovnané s entitami v Core Datách a rovnako ako v (1) zmazané. Ušetrilo by sa množstvo sťahovaných údajov, ale za cenu zložitejšieho zdrojového kódu a 2 requestov.
    //Aktuálne si myslím, žeby obidve riešenia sťahovali väčšie množstvo dát ako súčasné a tiež si myslím, že taká situácia v tomto prípade nenastane, ale je to na diskusiu, každý môže mať iný názor.
    
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
