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
    
    let examplePoints = [CLLocationCoordinate2D(latitude: 48.86666667, longitude: 2.333333), CLLocationCoordinate2D(latitude: 50.08333333, longitude: 14.466667), CLLocationCoordinate2D(latitude: -35.26666667, longitude: 149.133333), CLLocationCoordinate2D(latitude: 38.883333, longitude: -77), CLLocationCoordinate2D(latitude: 39.91666667, longitude: 116.383333), CLLocationCoordinate2D(latitude: -15.78333333, longitude: -47.916667), CLLocationCoordinate2D(latitude: -25.7, longitude: 28.216667), CLLocationCoordinate2D(latitude: 28.6, longitude: 77.2), CLLocationCoordinate2D(latitude: 55.75, longitude: 37.6), CLLocationCoordinate2D(latitude: 45.41666667, longitude: -75.7), CLLocationCoordinate2D(latitude: 9.083333333, longitude: 7.533333)]
    let capitalCities = ["Paris", "Prague", "Canberra", "Washington, D.C.", "Beijing", "Brasilia", "Pretoria", "New Delhi", "Moscow", "Ottawa", "Abuja"]
    let country = ["France", "Czechia", "Australia", "United States", "China", "Brazil", "South Africa", "India", "Russia", "Canada", "Nigeria"]
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var x = 0
        var views = [EtaAnnotation]()
        for ex in examplePoints {
            let annotationEta = EtaAnnotation(title: capitalCities[x], subtitle: country[x], coordinate: ex)
            views.append(annotationEta)
            x += 1
        }
        
        print(views)
        
        locationManager.requestWhenInUseAuthorization()
        
        //Show user location with necessary updates
        mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        //Delegates for location manager and map view
        locationManager.delegate = self
        mapView.delegate = self
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = MKAnnotationView()
        
        if let reusableAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "etaAnnotation") {
            annotationView = reusableAnnotationView
        }
        else {
            let annotationEtaView = EtaAnnotationView(annotation: annotation, reuseIdentifier: "etaAnnotation")
        }
        
        
        
        return annotationView
    }
}

