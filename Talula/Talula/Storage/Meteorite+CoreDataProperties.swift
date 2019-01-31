//
//  Meteorite+CoreDataProperties.swift
//  Talula
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//
//

import Foundation
import CoreData


extension Meteorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meteorite> {
        return NSFetchRequest<Meteorite>(entityName: "Meteorite")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var fall: String?
    @NSManaged public var geotype: String?
    @NSManaged public var meteoriteId: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var mass: String?
    @NSManaged public var name: String?
    
    func update(with jsonDictionary: [String: Any]) throws {
        guard
            let fall = jsonDictionary["fall"] as? String,
            let geolocation = jsonDictionary["geolocation"] as? [String:Any],
            let geotype = geolocation["type"] as? String,
            let coordinates = geolocation["coordinates"] as? [Double],
            let id = jsonDictionary["id"] as? String
        else {
            throw NSError(domain: "", code: 100, userInfo: nil)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS"
        
        self.fall = fall
        self.geotype = geotype
        self.longitude = coordinates[0]
        self.latitude = coordinates[1]
        self.meteoriteId = id
        
        self.name = jsonDictionary["name"] as? String
        self.mass = jsonDictionary["mass"] as? String
        if let year = jsonDictionary["year"] as? String {
            self.date = dateFormatter.date(from: year) as NSDate?
        }
        
//        print("METEORITE")
//        print(jsonDictionary.description)
//        print(self.description)
//        print(" ")
    }

}
