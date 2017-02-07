//
//  Directions.swift
//  Klozet
//
//  Created by Marek Fořt on 07/09/16.
//  Copyright © 2016 Marek Fořt. All rights reserved.
//

import Foundation
import UIKit
import MapKit


protocol DirectionsDelegate {
    var locationManager: CLLocationManager { get }
    var transportType: MKDirectionsTransportType? { get }
    var destinationCoordinate: CLLocationCoordinate2D { get }
}

extension DirectionsDelegate {
    //ETA for annotation view
    func getEta(completion: @escaping (_ eta: String) -> ())  {
        
        //Set path
        guard let directions = requestDirections(destinationCoordinate) else {return}
        
        //Calculate ETA
        directions.calculateETA(completionHandler: {
            etaResponse, error in
            guard let etaInterval = etaResponse?.expectedTravelTime else {return}
            
            let eta = self.convertEtaIntervalToString(etaInterval)
            
            completion(eta)
        })
    }
    
    //Converting ETA in NSTimeInterval to minutes or hours
    fileprivate func convertEtaIntervalToString(_ etaInterval: TimeInterval) -> String {
        let etaInt = NSInteger(etaInterval)
        
        //Number of seconds in hour
        let oneHour = 3600
        let minutes = (etaInt / 60) % 60
        if etaInt > oneHour {
            let hours = (etaInt / oneHour) % oneHour
            return "\(hours)h \(minutes)m"
        }
            
        else {
            return "\(minutes) min"
        }
        
        
    }
    
    
    //ETA estimate
    fileprivate func requestDirections(_ destination: CLLocationCoordinate2D) -> MKDirections? {
        
        guard
            let currentLocation = locationManager.location
        else {return nil}
        
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation.coordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination, addressDictionary: nil))
        
        if let transportType = self.transportType {
            request.transportType = transportType
        }
        else {
            request.transportType = .automobile
        }
        
        let directions = MKDirections(request: request)
        
        return directions
    }
    
    
}
