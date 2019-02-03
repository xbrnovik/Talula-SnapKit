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
    
    
    func getMeteorites(all:Bool, completion: @escaping(_ filmsDict: [[String: Any]]?, _ error: Error?) -> ()) {
        let meteoritesURL = all ? MeteoriteDataURLFactory.getFirebaseURL(date: nil) :  MeteoriteDataURLFactory.getFirebaseURL(date: Date())//TODO
        
        urlSession.dataTask(with: meteoritesURL!) { (data, response, error) in
            //not received data
            if let error = error {
                completion(nil, error)
                return
            }
            //check if received data exists
            guard
                let data = data
            else {
                let error = NSError(domain: Constants.error.dataDomain, code: Constants.error.emptyReceivedData, userInfo: nil)
                    completion(nil, error)
                    return
            }
            //serialize data
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                guard
                    let jsonDictionary = jsonObject as? [[String: Any]]
                else {
                    throw NSError(domain: Constants.error.dataDomain, code: Constants.error.incorrectDataFormat, userInfo: nil)
                }
                completion(jsonDictionary, nil)
            } catch {
                completion(nil, error)
            }
            
        }.resume()
    }
    
}
