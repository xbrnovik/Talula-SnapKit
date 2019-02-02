//
//  MasterDelegateDataSource.swift
//  Talula
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MasterDelegateDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var meteoritesFRC: NSFetchedResultsController<Meteorite>
    
    var presentDetailHandler: ((Meteorite) -> ())?
        
    init(meteoritesFRC: NSFetchedResultsController<Meteorite>) {
        self.meteoritesFRC = meteoritesFRC
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meteoritesFRC.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        let meteorite = meteoritesFRC.object(at: indexPath)
        let cell: MasterCell? = tableView.dequeueReusableCell(withIdentifier: Constants.ui.masterReusableCellId) as? MasterCell
        cell?.titleLabel.text = meteorite.name ?? "Unknown name"
        
        if let massNumber = (round(1000 * meteorite.mass) / 1000) as NSNumber?, let massString = Constants.numberFormatters.locale.string(from: massNumber), massNumber != 0 {
            cell?.subTitleLabel.text = "\(massString) g"
            cell?.iconImageView.image = meteorite.mass>10000 ? #imageLiteral(resourceName: "meteorite-big_right") : #imageLiteral(resourceName: "meteorite-small_right")
        } else {
            cell?.subTitleLabel.text = "Mass unknown"
            cell?.iconImageView.image = #imageLiteral(resourceName: "iconfinder_iStar_Design_Space_LineIcons_Live-6_3088387-1")
        }
        
        cell?.accessoryType = .disclosureIndicator
        print(meteorite.geotype?.description)
        return cell ?? defaultCell
        
    }
    
    // MARK: - UITableViewDelegate
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMeteorite = self.meteoritesFRC.object(at: indexPath)
        presentDetailHandler?(selectedMeteorite)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
