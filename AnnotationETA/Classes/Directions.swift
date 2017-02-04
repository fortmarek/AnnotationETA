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
    var locationDelegate: UserLocation? { get }
}

extension DirectionsDelegate {
    //ETA for annotation view
    func getEta(_ destination: CLLocationCoordinate2D, completion: @escaping (_ eta: String) -> ())  {
        
        //Set path
        let directions = requestDirections(destination)
        
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
    fileprivate func requestDirections(_ destination: CLLocationCoordinate2D) -> MKDirections {
        
        let request = MKDirectionsRequest()
        
        guard
            let locationDelegate = self.locationDelegate,
            let userLocation = locationDelegate.getUserLocation() else {return MKDirections()}
        
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation.coordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination, addressDictionary: nil))
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        
        return directions
    }
    
    
    func getDistanceString(_ destination: CLLocationCoordinate2D) -> String {
        
        let distance = getDistance(destination)
        
        //Metres to kilometres
        let kilometres = distance / 1000
        
        //Round number of kilometres to 1 decimal
        let roundedKilometres = round(kilometres * 10) / 10
        
        //Adding to kilometres number km
        let fullKilometresString = convertDecimalSeparator(roundedKilometres) + " km"
        
        return fullKilometresString
    }
    
    //Get distance
    func getDistance(_ destination: CLLocationCoordinate2D) -> Double {
        guard
            let locationDelegate = self.locationDelegate,
            let userLocation = locationDelegate.getUserLocation()
            else {return Double()}
        
        //Convert CLLocationCoordinate2D to CLLocation for distance
        let destinationLocation = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
        
        let distance = userLocation.distance(from: destinationLocation)
        
        return distance
        
    }
    
    fileprivate func convertDecimalSeparator(_ kilometres: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .decimal
        numberFormatter.usesGroupingSeparator = true
        
        //Double to NSNumber
        let kilometresNumber = NSNumber(value: kilometres)
        //Converting decimal separator, returning string
        guard let kilometresString = numberFormatter.string(from: kilometresNumber) else {return ""}
        
        
        return kilometresString
        
    }
}
