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
    
    var storage: MeteoriteStorage?

    override func setUp() {
        super.setUp()
        storage = MeteoriteStorage()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetById() {
        // Properties.
        let meteoriteId: String = "1"
        let name: String = "Test meteorite"
        let geotype: String = "A1"
        let latitude: Double = 1
        let longitude: Double = 1
        let mass: Float = 10
        // New meteorite.
        let meteorite = storage?.create()
        meteorite?.meteoriteId = meteoriteId
        meteorite?.name = name
        meteorite?.geotype = geotype
        meteorite?.latitude = latitude
        meteorite?.longitude = longitude
        meteorite?.mass = mass
        // Call to function.
        let savedMeteorite = storage?.getById(id: "1")
        // Test.
        XCTAssertEqual(savedMeteorite?.meteoriteId, meteoriteId)
        XCTAssertEqual(savedMeteorite?.name, name)
        XCTAssertEqual(savedMeteorite?.geotype, geotype)
        XCTAssertEqual(savedMeteorite?.latitude, latitude)
        XCTAssertEqual(savedMeteorite?.longitude, longitude)
        XCTAssertEqual(savedMeteorite?.mass, mass)
    }

}
