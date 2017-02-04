//
//  AnnotationETAView.swift
//  Pods
//
//  Created by Marek Fořt on 2/2/17.
//
//

import Foundation
import MapKit

open class EtaAnnotationView: MKAnnotationView {
    
    public override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.annotation = annotation
        self.canShowCallout = true
        self.image = UIImage(named: "Pin")
        self.centerOffset = CGPoint(x: 0, y: -(self.frame.height)/2)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
