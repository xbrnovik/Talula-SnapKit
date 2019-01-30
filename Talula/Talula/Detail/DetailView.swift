//
//  DetailView.swift
//  Talula
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class DetailView: BaseView {
    
    private var didSetupConstraints = false
    
    let mapView: MKMapView = {
        let view = MKMapView()
        return view
    }()
    
    
    override init() {
        super.init()
        self.setNeedsUpdateConstraints()
        self.backgroundColor = .white
        self.view.addSubview(mapView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        
        if (!didSetupConstraints) {
            
            mapView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
}
