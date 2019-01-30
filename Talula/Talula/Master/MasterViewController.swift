//
//  MasterViewController.swift
//  Talula
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
//
//  ViewController.swift
//  Sion
//
//  Created by Diana Brnovik on 29/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    let masterView: MasterView = {
        let view = MasterView()
        view.backgroundColor = UIColor.white
        view.listView.register(MasterCell.self, forCellReuseIdentifier: Constants.ui.masterReusableCellId)
        return view
    }()
    
    let masterDelegateDataSource: MasterDelegateDataSource
    
    let detailViewConstroller: DetailViewController
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        self.masterDelegateDataSource = MasterDelegateDataSource()
        self.detailViewConstroller = DetailViewController()
        super.init(nibName: nil, bundle: nil)
        
        self.view = masterView
        self.title = "Master"
        masterView.listView.delegate = masterDelegateDataSource
        masterView.listView.dataSource = masterDelegateDataSource
        masterDelegateDataSource.presentDetailHandler = { [weak self] (meteorite) in
            self?.presentDetail(meteorite: meteorite)
        }
        
        let meteoriteOne = Meteorite(id: 1, fall: "Fell", geotype: "Point", latitude: 50.775, longitude: 6.08333, mass: 21, name: "Aachen", year: Date())
        let meteoriteTwo = Meteorite(id: 1, fall: "Fell", geotype: "Point", latitude: 56.18333, longitude: 10.23333, mass: 720, name: "Aarhus", year: Date())
        self.masterDelegateDataSource.setNewFetchResults(meteorites: [meteoriteOne,meteoriteTwo])
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

