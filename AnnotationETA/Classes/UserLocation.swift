//
//  UserLocation.swift
//  Pods
//
//  Created by Marek Fořt on 2/4/17.
//
//

import Foundation
import MapKit


//protocol UserLocation: CLLocationManagerDelegate, MKMapViewDelegate {
//    var locationManager: CLLocationManager { get }
//    var mapView: MKMapView! { get }
//}
//
//extension UserLocation {
//    func getUserLocation() -> CLLocation? {
//        guard let location = locationManager.location else {return nil}
//        return location
//    }
//    
//    func startTrackingLocation() {
//        //Tracking user's location init
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//        
//        mapView.showsUserLocation = true
//    }
//    
//}
