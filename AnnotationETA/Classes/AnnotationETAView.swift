//
//  AnnotationETAView.swift
//  Pods
//
//  Created by Marek Fořt on 2/2/17.
//
//

import Foundation
import MapKit

class AnnotationEtaView: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.annotation = annotation
        self.canShowCallout = true
        self.image = UIImage(named: "Pin")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
