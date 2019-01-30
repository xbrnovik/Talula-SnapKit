//
//  ViewController.swift
//  Talula
//
//  Created by Diana Brnovik on 30/01/2019.
//  Copyright © 2019 Diana Brnovik. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    let detailView: DetailView = {
        let view = DetailView()
        view.backgroundColor = UIColor.white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        self.view = detailView
        self.title = "Detail"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ meteorite: Meteorite) {
        
        // Delete old annotations.
        if detailView.mapView.annotations.count > 0 {
            let oldAnnotations = detailView.mapView.annotations
            detailView.mapView.removeAnnotations(oldAnnotations)
        }
        
        // Define map data
        let latitude: CLLocationDegrees = meteorite.latitude
        let longitude: CLLocationDegrees = meteorite.longitude
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        let span = MKCoordinateSpan(latitudeDelta: Constants.map.latitudeDelta, longitudeDelta: Constants.map.longitudeDelta)
        let region = MKCoordinateRegion(center: location, span: span)
        
        // Create new annotation and set region
        let newAnnotation = MKPointAnnotation()
        newAnnotation.title = meteorite.name
        newAnnotation.coordinate = location
        newAnnotation.subtitle = meteorite.geotype
        detailView.mapView.addAnnotation(newAnnotation)
        detailView.mapView.setRegion(region, animated: true)
        
    }

}

