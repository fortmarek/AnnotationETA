//
//  ViewController.swift
//  AnnotationETA
//
//  Created by fortmarek on 02/01/2017.
//  Copyright (c) 2017 fortmarek. All rights reserved.
//

import UIKit
import MapKit
import AnnotationETA

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.requestWhenInUseAuthorization()
        
        mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        

        locationManager.delegate = self
        mapView.delegate = self
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotationEta = annotation as? AnnotationEtaView else {return nil}
        return annotationEta
    }
}

