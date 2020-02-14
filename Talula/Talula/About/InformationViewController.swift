//
//  InformationController.swift
//  Talula
//
//  Created by Diana Brnovik on 03/02/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    
    let informationView: InformationView = {
        let view = InformationView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view = informationView
        self.title = "Information"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

