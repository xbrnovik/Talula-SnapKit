//
//  BackgroundSync.swift
//  Talula
//
//  Created by Diana Brnovik on 31/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import UIKit

class DataSync {
    
    internal var timestampKey = "updateTimestamp"
    
    func backgroundRun(_ completionHandler: @escaping (UIBackgroundFetchResult) -> ()) {
        if needsUpdateData() {
            SourceDataSync().fetchMeteorites(completion: { (error) in
                if let error = error {
                    print("Fetch error: \(error)")
                    completionHandler(.failed)
                } else {
                    completionHandler(.newData)
                    self.setLastUpdated()
                }
            })
        }
    }
    
    func foregroundRun() {
        if needsUpdateData() {
            SourceDataSync().fetchMeteorites(completion: { (error) in
                if let error = error {
                    print("Fetch error: \(error)")
                } else {
                    self.setLastUpdated()
                }
            })
        }
    }
    
    private func setLastUpdated() {
        let timestamp = Int(Date().timeIntervalSince1970)
        UserDefaults.standard.set(timestamp, forKey: timestampKey)
    }
    
    private func needsUpdateData() -> Bool {
        var result = true
        let updateTimestamp = UserDefaults.standard.integer(forKey: timestampKey) //If updateTimestamp is not set, UserDefaults return 0.
        let currentTimestamp = Int(Date().timeIntervalSince1970)
        if updateTimestamp >= currentTimestamp { //TODO: Add to calculation one day difference (24*60*60 = 86400 seconds).
            result = false
        }
        return result
    }
    
}
