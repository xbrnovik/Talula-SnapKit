//
//  MasterViewController.swift
//  Talula
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MasterViewController: UIViewController {
    
    let masterView: MasterView = {
        let view = MasterView()
        view.backgroundColor = UIColor.white
        view.listView.register(MasterCell.self, forCellReuseIdentifier: Constants.ui.masterReusableCellId)
        return view
    }()
    
    var masterDelegateDataSource: MasterDelegateDataSource?
    var meteoriteStorage: MeteoriteStorage?
    
    let detailViewConstroller = DetailViewController()
    let informationController = InformationViewController()
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view = masterView
        self.title = "Meteorites"
        // Sets storage.
        self.meteoriteStorage = MeteoriteStorage(self)
        guard let meteoriteStorage = meteoriteStorage else { return }
        // Sets delegates.
        masterDelegateDataSource = MasterDelegateDataSource(meteoritesFRC: meteoriteStorage.fetchedResultsController)
        masterView.listView.delegate = masterDelegateDataSource
        masterView.listView.dataSource = masterDelegateDataSource
        masterDelegateDataSource?.presentDetailHandler = { [weak self] meteorite in
            self?.presentDetail(meteorite: meteorite)
        }
        // Sets info button.
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(presentInformation), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Present
    
    /// Presents master view.
    func presentMaster(from controller: UINavigationController, animated: Bool)  {
        controller.pushViewController(self, animated: animated)
    }
    
    /// Presents detail view.
    func presentDetail(meteorite: Meteorite) {
        detailViewConstroller.setModel(meteorite)
        self.navigationController?.pushViewController(detailViewConstroller, animated: true)
    }
    
    /// Presents informational view.
    @objc func presentInformation() {
        self.navigationController?.pushViewController(informationController, animated: true)
    }
    
}

extension MasterViewController: NSFetchedResultsControllerDelegate {
    
    /// Updates meteorites tableview with new content saved.
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.setAnimation(for: self.masterView.listView)
            self.masterView.listView.reloadData()
        }
    }
    
    /// Animates new content of view.
    private func setAnimation(for view: UIView) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .fade
        view.layer.add(transition, forKey: nil)
    }
    
}
