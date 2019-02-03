//
//  MeteoriteDataURLFactory.swift
//  Talula
//
//  Created by Diana Brnovik on 03/02/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import UIKit

class MeteoriteDataURLFactory {
    
    class func getURL(date: Date?) -> URL? {
        let urlBase = "https://data.nasa.gov/resource/y77d-th95.json?"
        let urlToken = "$$app_token=vkpZsq6vJE0i7wvOkP2ybNIbm"
        let urlSelect = "&$select=id,reclat,reclong,recclass,mass,year,name"
        var urlWhere = ""
        
        if let date = date {
            let dateString = Constants.dateFormatters.iso.string(from: date)
            urlWhere = "&$where=year>=\"2011-01-01T00:00:00\"AND:updated_at>\"" + dateString + "Z\"&fall=Fell"
        } else {
            
            urlWhere = "&$where=year>=\"2011-01-01T00:00:00\"&fall=Fell"
            
        }
        
        let urlComplete = urlBase+urlToken+urlWhere+urlSelect
        
        //let meteoritesURL = URL(string: urlComplete)
        if let urlEscapedString = urlComplete.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) , let escapedURL = URL(string: urlEscapedString) {
            return escapedURL
        } else {
            return nil
        }
        
    }
    
    class func getFirebaseURL(date: Date?) -> URL? {
        
        if let date = date {
           return URL(string: "https://nasadata-5b34c.firebaseio.com/meteorites4.json")
        } else {
           return URL(string: "https://nasadata-5b34c.firebaseio.com/meteorites3.json")
        }
        
    }
}
