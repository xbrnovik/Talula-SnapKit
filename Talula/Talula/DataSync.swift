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
    
    internal var timestampKey = "updateTimestamp"
    internal var updateDelay = 86400
    
    func backgroundRun(_ completionHandler: @escaping (UIBackgroundFetchResult) -> ()) {
        if needsUpdateData() {
            let all = needsDownloadAllData()
            SourceDataSync().fetchMeteorites(all: all) { (error) in
                if let error = error {
                    print("Fetch error: \(error)")
                    completionHandler(.failed)
                } else {
                    completionHandler(.newData)
                    self.setLastUpdated()
                }
            }
        }
    }
    
    func foregroundRun() {
        if needsUpdateData() {
            let all = needsDownloadAllData()
            SourceDataSync().fetchMeteorites(all: all) { (error) in
                if let error = error {
                    print("Fetch error: \(error)")
                } else {
                    self.setLastUpdated()
                }
            }
        }
    }
    
    private func setLastUpdated() {
        let timestamp = Int(Date().timeIntervalSince1970)
        UserDefaults.standard.set(timestamp, forKey: timestampKey)
    }
    
    private func needsUpdateData() -> Bool {
        var result = true
        //If updateTimestamp is not set, UserDefaults return 0.
        let updateTimestamp = UserDefaults.standard.integer(forKey: timestampKey)
        let currentTimestamp = Int(Date().timeIntervalSince1970)
        //Adds to calculation one day difference (24*60*60 = 86400 seconds).
        let calculatedTimestamp = currentTimestamp+updateTimestamp
        if updateTimestamp >= calculatedTimestamp {
            result = false
        }
        return result
    }
    
    private func needsDownloadAllData() -> Bool {
        var result = false
        //If updateTimestamp is not set, UserDefaults return 0.
        let updateTimestamp = UserDefaults.standard.integer(forKey: timestampKey)
        if updateTimestamp == 0 {
            result = true
        }
        return result
    }
    
}
