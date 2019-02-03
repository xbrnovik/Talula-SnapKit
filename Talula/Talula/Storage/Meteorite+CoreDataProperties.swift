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
        // Checks meteorite attributes - fallen meteorite has its ID and location.
        guard
            let id = jsonDictionary["id"] as? String,
            // NASA stores probably opposite notation, "reclong" is latitude with values from -180 to 180.
            let latitudeString = jsonDictionary["reclong"] as? String,
            let latitude = Double(latitudeString),
            // NASA stores probably opposite notation, "reclat" is longitude with values from -90 to 90.
            let longitudeString = jsonDictionary["reclat"] as? String,
            let longitude = Double(longitudeString)
        else {
            throw NSError(domain: "", code: 100, userInfo: nil)
        }
        // Sets obligatory attributes.
        self.meteoriteId = id
        self.longitude = latitude
        self.latitude = longitude
        // Sets voluntary attributes.
        self.name = jsonDictionary["name"] as? String
        self.geotype = jsonDictionary["recclass"] as? String
        if let mass = jsonDictionary["mass"] as? NSString {
            self.mass = mass.floatValue
        } else {
            // Float value cannot be nil, as well as mass of meteorite should not be 0 g - zero value is considered as unknown.
            self.mass = 0
        }
        
    }

}
