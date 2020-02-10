//
//  DataSync.swift
//  Talula
//
//  Created by Diana Brnovik on 31/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import UIKit

class DataSync {
    
    /// Bool value saying if it is neccessary download new data.
    var needsUpdateData: Bool {
        var result = true
        // If updateTimestamp is not set, UserDefaults return 0.
        let updateTimestamp = UserDefaults.standard.integer(forKey: Constants.dataSync.timestampKey)
        let currentTimestamp = Int(Date().timeIntervalSince1970)
        // Adds to calculation one day difference (24*60*60 = 86400 seconds).
        let calculatedTimestamp = updateTimestamp + Constants.dataSync.updateDelay
        if calculatedTimestamp >= currentTimestamp {
            result = false
        }
        return result
    }
    
    /// Bool value saying if it is neccessary download all data.
    var needsDownloadAllData: Bool {
        var result = false
        // If updateTimestamp is not set, UserDefaults return 0.
        let updateTimestamp = UserDefaults.standard.integer(forKey: Constants.dataSync.timestampKey)
        if updateTimestamp == 0 {
            result = true
        }
        return result
    }
    
    /**
     Updates meteorite data on background call.
     
     - Parameter completionHandler: Complection handling result of data fetch.
     */
    func backgroundRun() {
        guard needsUpdateData else {
            return
        }
        SourceDataSync().fetchMeteorites(all: needsDownloadAllData) { [unowned self] (error) in
            if let error = error {
                NSLog("Fetch error: \(error)")
            } else {
                self.setLastUpdated()
            }
        }
    }
    
    /// Updates meteorite data on foreground call.
    func foregroundRun() {
        guard needsUpdateData else {
            return
        }
        SourceDataSync().fetchMeteorites(all: needsDownloadAllData) { [unowned self] (error) in
            if let error = error {
                NSLog("Fetch error: \(error)")
            } else {
                self.setLastUpdated()
            }
        }
    }
    
    /// Sets when was last successfull update (sync) of meteorites.
    private func setLastUpdated() {
        let timestamp = Int(Date().timeIntervalSince1970)
        UserDefaults.standard.set(timestamp, forKey: Constants.dataSync.timestampKey)
    }
    
}
