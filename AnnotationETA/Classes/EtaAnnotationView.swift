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
    
        setCalloutAccessoryView()
    }
    
    func setCalloutAccessoryView() {
        
        //Detailed toilet info button
        let rightButton = UIButton.init(type: .detailDisclosure)
        rightButton.tintColor = UIColor(red: 1.00, green: 0.50, blue: 0.00, alpha: 1.0)
        //rightButton.addTarget(self, action: #selector(detailButtonTapped), for: .touchUpInside)
        rightCalloutAccessoryView = rightButton
        
        //Left button with ETA
        leftCalloutAccessoryView = DirectionButton()
        
        //Add target to get directions
        //leftButton.addTarget(self, action: #selector(getDirectionsFromAnnotation), forControlEvents: .TouchUpInside)
    }
    
//    func detailButtonTapped() {
//        guard
//            let toilet = annotation as? Toilet,
//            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailVC") as? DetailViewController,
//            let ShowDelegate = self.ShowDelegate
//            else {return}
//        
//        viewController.navigationController?.navigationBar.tintColor = Colors.pumpkinColor
//        viewController.toilet = toilet
//        
//        ShowDelegate.showViewController(viewController: viewController)
//        
//    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
