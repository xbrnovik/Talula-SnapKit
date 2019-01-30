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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        self.masterDelegateDataSource = MasterDelegateDataSource()
        super.init(nibName: nil, bundle: nil)
        self.view = masterView
        self.title = "Master"
        masterView.listView.delegate = masterDelegateDataSource
        masterView.listView.dataSource = masterDelegateDataSource
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

