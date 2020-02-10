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
    
    private let meteoritesFRC: NSFetchedResultsController<Meteorite>
    
    var presentDetailHandler: ((Meteorite) -> ())?
    
    // MARK: - Init
        
    init(meteoritesFRC: NSFetchedResultsController<Meteorite>) {
        self.meteoritesFRC = meteoritesFRC
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        displayFooterView(tableView)
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meteoritesFRC.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        let meteorite = meteoritesFRC.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ui.masterReusableCellId) as? MasterCell
        cell?.titleLabel.text = meteorite.name ?? "Unknown name"
        
        if
        let massNumber = (round(1000 * meteorite.mass) / 1000) as NSNumber?,
        let massString = Constants.numberFormatters.localeDecimal.string(from: massNumber),
        massNumber != 0 {
            
            cell?.subTitleLabel.text = "\(massString) g"
            if meteorite.mass >= 10000 {
                cell?.iconImageView.image = #imageLiteral(resourceName: "BigMeteorite")
            } else if meteorite.mass >= 1000 {
                cell?.iconImageView.image = #imageLiteral(resourceName: "SmaillMeteorite")
            } else {
                cell?.iconImageView.image = #imageLiteral(resourceName: "OtherMeteorite")
            }
        } else {
            cell?.subTitleLabel.text = "Mass unknown"
        }
        
        cell?.accessoryType = .disclosureIndicator
        return cell ?? defaultCell
        
    }
    
    // MARK: - UITableViewDelegate
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.ui.bigCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMeteorite = meteoritesFRC.object(at: indexPath)
        presentDetailHandler?(selectedMeteorite)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - FooterView
    
    /// Sets footer view by the count of meteorites.
    func displayFooterView(_ tableView: UITableView) {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: Constants.ui.footerHeight)
        let footer = MasterSectionFooterView(frame: frame)
        if let count = meteoritesFRC.fetchedObjects?.count {
            let text = count == 1 ? "\(count) meteorite" : "\(count) meteorites"
            footer.titleLabel.text = text
        } else {
            footer.titleLabel.text = "Unknown count of meteorites"
        }
        tableView.tableFooterView = footer
    }
}
