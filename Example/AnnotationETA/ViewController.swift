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

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    let etaAnnotations = [EtaAnnotation(title: "Paris", subtitle: "Capital City of France", coordinate: CLLocationCoordinate2D(latitude: 48.86666667, longitude: 2.333333)), EtaAnnotation(title: "Prague", subtitle: "Capital City of Czechia", coordinate: CLLocationCoordinate2D(latitude: 50.088172, longitude: 14.417863)), EtaAnnotation(title: "Canberra", subtitle: "Capital City of Australia", coordinate: CLLocationCoordinate2D(latitude: -35.26666667, longitude: 149.133333)), EtaAnnotation(title: "Washingtion, D.C.", subtitle: "Capital City of United States", coordinate: CLLocationCoordinate2D(latitude: 38.883333, longitude: -77)), EtaAnnotation(title: "Beijing", subtitle: "Capital City of China", coordinate: CLLocationCoordinate2D(latitude: 39.91666667, longitude: 116.383333)), EtaAnnotation(title: "Brasilia", subtitle: "Capital City of Brazil", coordinate: CLLocationCoordinate2D(latitude: -15.78333333, longitude: -47.916667)), EtaAnnotation(title: "Pretoria", subtitle: "Capital City of South Africa", coordinate: CLLocationCoordinate2D(latitude: -25.7, longitude: 28.216667)), EtaAnnotation(title: "New Delhi", subtitle: "Capital City of India", coordinate: CLLocationCoordinate2D(latitude: 28.6, longitude: 77.2)), EtaAnnotation(title: "Moscow", subtitle: "Capital City of Russia", coordinate: CLLocationCoordinate2D(latitude: 55.75, longitude: 37.6)), EtaAnnotation(title: "Ottawa", subtitle: "Capital City of Canada", coordinate: CLLocationCoordinate2D(latitude: 45.41666667, longitude: -75.7)), EtaAnnotation(title: "Abuja", subtitle: "Capital City of Nigeria", coordinate: CLLocationCoordinate2D(latitude: 9.083333333, longitude: 7.533333))]
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.requestWhenInUseAuthorization()
        
        //Show user location with necessary updates
        mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        //Delegates for location manager and map view
        locationManager.delegate = self
        mapView.delegate = self
        
        
        DispatchQueue.main.async(execute: {
            //Placing toilets on the map
            self.mapView.addAnnotations(self.etaAnnotations)
        })
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {return nil}
        
        var annotationView = MKAnnotationView()
        
        if let reusableAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "etaAnnotation") {
            annotationView = reusableAnnotationView
        }
        else {
            let annotationEtaView = EtaAnnotationView(annotation: annotation, reuseIdentifier: "etaAnnotation")
            annotationEtaView.pinColor = UIColor(red: 1.00, green: 0.50, blue: 0.00, alpha: 1.0)
            
            annotationEtaView.setDetailShowButton()
            annotationEtaView.rightButton?.addTarget(self, action: #selector(detailButtonTapped), for: .touchUpInside)
            
            annotationView = annotationEtaView
        }
        
        return annotationView
    }
    
    func detailButtonTapped() {
        guard
            mapView.selectedAnnotations.count == 1,
            let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailVC") as? DetailViewController
        else {return}
        
        detailViewController.annotation = mapView.selectedAnnotations[0]
        
        self.present(detailViewController, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else {return}
        if annotation is MKUserLocation {return}
        
        view.leftCalloutAccessoryView = DirectionButton(destinationCoordinate: annotation.coordinate, locationManager: self.locationManager, transportType: .automobile, destinationName: annotation.title ?? "")
    }
}

extension ViewController: CLLocationManagerDelegate {
    //Heading
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        //Ensure heading's value is positive
        let heading = newHeading.trueHeading > 0 ? newHeading.trueHeading : newHeading.magneticHeading
        
        //Orientate map according to where iPhone's facing
        let mapCamera = mapView.camera
        mapCamera.heading = heading
        mapView.setCamera(mapCamera, animated: false)
    }
    
    //The initial positon and region of the map
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Locations.last = current location
        guard let location = locations.last else {return}
        
        //Position
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        //Region
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
        
        //Show region in mapView
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
        
    }
    
    //Location manager fail
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Errors: \(error)")
    }
}
