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
            cell?.iconImageView.image = meteorite.mass>10000 ? #imageLiteral(resourceName: "BigMeteorite") : #imageLiteral(resourceName: "SmaillMeteorite")
        } else {
            cell?.subTitleLabel.text = "Mass unknown"
            cell?.iconImageView.image = #imageLiteral(resourceName: "OtherMeteorite")
        }
        
        cell?.accessoryType = .disclosureIndicator
        print(meteorite.geotype?.description)
        return cell ?? defaultCell
        
    }
    
    // MARK: - UITableViewDelegate
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.ui.bigCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMeteorite = self.meteoritesFRC.object(at: indexPath)
        presentDetailHandler?(selectedMeteorite)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = MasterSectionFooterView()
        if let count = self.meteoritesFRC.fetchedObjects?.count {
            footer.titleLabel.text = "\(count) meteorite(s)"
        } else {
            footer.titleLabel.text = "Unknown count of meteorites"
        }
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
}
