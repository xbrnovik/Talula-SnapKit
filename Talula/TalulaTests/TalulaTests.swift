//
//  TalulaTests.swift
//  TalulaTests
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import XCTest
@testable import Talula
import CoreData

class TalulaTests: XCTestCase {
    
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "Talula")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
    
//    var storage: AppStorage?

    override func setUp() {
        super.setUp()
//        storage = AppStorage(managedObjectContext: persistentContainer.viewContext)
        
        
        
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetAll() {
//        let newMeteorite = storage?.newObject()
//        newMeteorite?.name = "moje superne"
//        storage?.create()
//
//        let itemFRC = storage!.getAll()
//
//        print(itemFRC.fetchedObjects!.count)
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
