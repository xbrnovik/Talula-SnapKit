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
    
    var masterDelegateDataSource: MasterDelegateDataSource? = nil
    var meteoriteStorage: MeteoriteStorage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.view = masterView
        self.title = "Meteorites"
        
        self.meteoriteStorage = MeteoriteStorage(self)
        
        guard
            let meteoriteStorage = meteoriteStorage
        else {
            return
        }
        
        masterDelegateDataSource = MasterDelegateDataSource(meteoritesFRC: meteoriteStorage.fetchedResultsController)
        masterView.listView.delegate = masterDelegateDataSource
        masterView.listView.dataSource = masterDelegateDataSource
        masterDelegateDataSource?.presentDetailHandler = { [weak self] (meteorite) in
            self?.presentDetail(meteorite: meteorite)
        }
        
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "test", style: .done, target: self, action: #selector(presentInformation))
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(presentInformation), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentMaster(from controller: UINavigationController, animated: Bool)  {
        controller.pushViewController(self, animated: animated)
    }
    
    func presentDetail(meteorite: Meteorite) {
        let detailViewConstroller = DetailViewController()
        detailViewConstroller.setModel(meteorite)
        self.navigationController?.pushViewController(detailViewConstroller, animated: true)
    }
    
    @objc func presentInformation() {
        let informationController = InformationViewController()
        self.navigationController?.pushViewController(informationController, animated: true)
    }
    
}

extension MasterViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async { [weak self] in
            if let self = self {
                self.setAnimation(for: self.masterView.listView)
                self.masterView.listView.reloadData()
            }
        }
    }
    
    private func setAnimation(for view: UIView) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .fade
        view.layer.add(transition, forKey: nil)
    }
    
}
