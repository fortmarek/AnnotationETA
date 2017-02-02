//
//  AnnotationEta.swift
//  Pods
//
//  Created by Marek Fořt on 2/2/17.
//
//

import Foundation
import MapKit


open class EtaAnnotation: NSObject, MKAnnotation {
    //Annotation properties 
    
    public var title: String?
    public var subtitle: String?
    public let coordinate: CLLocationCoordinate2D
    
    public init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        
        //Coordinate
        self.coordinate = coordinate
        
        //Safely unwrap title and subtitle (they could be nil)
        if let title = title {
            self.title = title
        }
        
        if let subtitle = subtitle {
            self.subtitle = subtitle
        }
    }
}
