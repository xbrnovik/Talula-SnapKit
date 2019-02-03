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
            urlWhere = "&$where=year%3E=%222011-01-01T00:00:00%22AND:updated_at%3E%22" + dateString + "Z%22&fall=Fell"
        } else {
            
            urlWhere = "&$where=year%3E=%222011-01-01T00:00:00%22&fall=Fell"
            
        }
        
        let urlComplete = urlBase+urlToken+urlWhere+urlSelect
        //let meteoritesURL = urlComplete.getCleanedURL()
        let meteoritesURL = URL(string: urlComplete)
        
        return meteoritesURL
    }
    
    class func getFirebaseURL(date: Date?) -> URL? {
        
        if let date = date {
            return URL(string: "https://nasadata-5b34c.firebaseio.com/meteorites4.json")
        } else {
           return URL(string: "https://nasadata-5b34c.firebaseio.com/meteorites3.json")
        }
        
    }
}

extension String {
    func getCleanedURL() -> URL? {
        guard self.isEmpty == false else {
            return nil
        }
        if let url = URL(string: self) {
            return url
        } else {
            if let urlEscapedString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) , let escapedURL = URL(string: urlEscapedString){
                return escapedURL
            }
        }
        return nil
    }
}
