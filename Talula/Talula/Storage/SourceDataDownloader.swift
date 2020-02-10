//
//  SourceDataStorage.swift
//  Talula
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation

class SourceDataDownloader {
    
    private let urlSession = URLSession.shared
    
    /**
     Downloads meteorite data from NASA API using URLSession.
     
     - Parameters:
             - all: Information saying if all data should be download.
             - completion: Completion with obtained data or obtained error.
     */
    func getMeteorites(all: Bool, completion: @escaping(_ meteoritesDict: [[String: Any]]?, _ error: Error?) -> ()) {
        // Creates meteorite URL.
        let lastUpdateTimestamp = UserDefaults.standard.integer(forKey: Constants.dataSync.timestampKey)
        let lastUpdateDate = Date.init(timeIntervalSince1970: TimeInterval(lastUpdateTimestamp))
        var url: URL?
        if all {
            url = MeteoriteDataURLFactory.getURL(date: nil)
        } else {
            url = MeteoriteDataURLFactory.getURL(date: lastUpdateDate)
        }
        // Checks is defined URL of session.
        guard let meteoritesURL = url else {
            let error = NSError(domain: Constants.error.dataDomain, code: Constants.error.wrongURLFormat, userInfo: nil)
            completion(nil, error)
            return
        }
        // Starts url session with given url.
        urlSession.dataTask(with: meteoritesURL) { (data, response, error) in
            // Checks if received data exists.
            guard let data = data else {
                let error = NSError(domain: Constants.error.dataDomain, code: Constants.error.emptyReceivedData, userInfo: nil)
                completion(nil, error)
                return
            }
            // Serializes received data.
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonDictionary = jsonObject as? [[String: Any]] else {
                    throw NSError(domain: Constants.error.dataDomain, code: Constants.error.incorrectDataFormat, userInfo: nil)
                }
                completion(jsonDictionary, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
}
