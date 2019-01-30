//
//  Meteorite.swift
//  Talula
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation

class Meteorite {
    
    let id: Int
    let fall: String
    let geotype: String
    let latitude: Double
    let longitude: Double
    let mass: Int
    let name: String
    let year: Date
    
    init(id: Int, fall: String, geotype: String, latitude: Double, longitude: Double, mass: Int, name: String, year: Date) {
        self.id = id
        self.fall = fall
        self.geotype = geotype
        self.latitude = latitude
        self.longitude = longitude
        self.mass = mass
        self.name = name
        self.year = year
    }
    
}
