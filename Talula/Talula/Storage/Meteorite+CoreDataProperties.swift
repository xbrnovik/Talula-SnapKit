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

    @NSManaged public var meteoriteId: String?
    @NSManaged public var name: String?
    @NSManaged public var geotype: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var mass: Float
    
    func update(with jsonDictionary: [String: Any]) throws {
        //fallen meteorite has its id and location
        guard
            let id = jsonDictionary["id"] as? String,
            let latitudeString = jsonDictionary["reclat"] as? String,
            let latitude = Double(latitudeString),
            let longitudeString = jsonDictionary["reclong"] as? String,
            let longitude = Double(longitudeString)
        else {
            throw NSError(domain: "", code: 100, userInfo: nil)
        }
        //obligatory properties
        self.meteoriteId = id
        self.longitude = latitude
        self.latitude = longitude
        //voluntary properties
        self.name = jsonDictionary["name"] as? String
        self.geotype = jsonDictionary["recclass"] as? String
        if let mass = jsonDictionary["mass"] as? NSString {
            self.mass = mass.floatValue
        } else {
            self.mass = 0 // considered as unknown
        }
        
    }

}
