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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isZoomEnabled = true
        view.showsCompass = true
        return view
    }()
    
    let scaleView: MKScaleView = {
       let view = MKScaleView(mapView: nil)
        view.scaleVisibility = .visible
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init() {
        super.init()
        self.setNeedsUpdateConstraints()
        self.backgroundColor = .white
        self.view.addSubview(mapView)
        self.view.addSubview(scaleView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        scaleView.mapView = mapView
        
        if (!didSetupConstraints) {
            
            mapView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            scaleView.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().offset(-45)
                make.right.equalToSuperview().offset(-15)
                make.height.equalTo(25)
            }
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
}
