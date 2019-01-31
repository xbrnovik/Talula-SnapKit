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
    let detailViewConstroller: DetailViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        self.detailViewConstroller = DetailViewController()
        super.init(nibName: nil, bundle: nil)
        
        self.view = masterView
        self.title = "Master"
        
        self.meteoriteStorage = MeteoriteStorage(delegate: self)
        
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
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentMaster(from controller: UINavigationController, animated: Bool)  {
        controller.pushViewController(self, animated: animated)
    }
    
    func presentDetail(meteorite: Meteorite) {
        detailViewConstroller.setModel(meteorite)
        self.navigationController?.pushViewController(detailViewConstroller, animated: true)
    }
    
}

extension MasterViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        self.masterView.listView.reloadData()
    }
    
}
