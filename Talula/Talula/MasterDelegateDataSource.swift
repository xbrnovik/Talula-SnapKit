//
//  MasterDelegateDataSource.swift
//  Talula
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import UIKit

class MasterDelegateDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var meteorites: [String] = ["Prvy","Druhy","Treti"]
    
    var hasResults: Bool {
        get {
            if !meteorites.isEmpty {
                return true
            } else {
                return false
            }
            
        }
    }
    
    var presentDetailHandler: ((String) -> ())?
        
    func setNewFetchResults(meteorites: [String]) {
        self.meteorites = meteorites
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meteorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        let cell: MasterCell? = tableView.dequeueReusableCell(withIdentifier: Constants.ui.masterReusableCellId) as? MasterCell
        cell?.titleLabel.text = meteorites[indexPath.row]
        return cell ?? defaultCell
        
    }
    
    // MARK: - UITableViewDelegate
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMeteorite = meteorites[indexPath.row]
        presentDetailHandler?(selectedMeteorite)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
