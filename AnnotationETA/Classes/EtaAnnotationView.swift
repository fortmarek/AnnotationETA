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
        //self.image = UIImage(named: "Pin")
        self.frame = CGRect(origin: self.frame.origin, size: CGSize(width: 20, height: 40))
        self.centerOffset = CGPoint(x: 0, y: -(self.frame.height)/2)
        self.backgroundColor = UIColor.clear
        
        
        setCalloutAccessoryView()
    }
    
    override open func draw(_ rect: CGRect) {
        
        var bigCircleRect = rect
        bigCircleRect.size.height = rect.size.height/2
        let path = UIBezierPath(ovalIn: bigCircleRect)
        UIColor(red: 1.00, green: 0.50, blue: 0.00, alpha: 1.0).setFill()
        path.fill()
        
        let bottomPath = UIBezierPath()
        bottomPath.move(to: CGPoint(x: 0, y: bigCircleRect.size.height/2 + 2))
        bottomPath.addLine(to: CGPoint(x: self.frame.width, y: bigCircleRect.size.height/2 + 2))
        //bottomPath.addLine(to: CGPoint(x: self.frame.width/2, y: self.frame.height))
        bottomPath.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height - 2), radius: 2, startAngle: CGFloat(0), endAngle: CGFloat(M_PI), clockwise: true)
        bottomPath.addLine(to: CGPoint(x: 0, y: bigCircleRect.size.height/2 + 2))
        bottomPath.close()
        UIColor(red: 1.00, green: 0.50, blue: 0.00, alpha: 1.0).setFill()
        //bottomPath.stroke()
        bottomPath.fill()
        
        let smallSize = bigCircleRect.size.width * 0.4
        let smallCircleRect = CGRect(x: (bigCircleRect.size.width - smallSize)/2, y: (bigCircleRect.size.width - smallSize)/2, width: smallSize, height: smallSize)
        let smallPath = UIBezierPath(ovalIn: smallCircleRect)
        UIColor.white.setFill()
        smallPath.fill()
        

        
    }
    
    func setCalloutAccessoryView() {
        
        //Detailed toilet info button
        let rightButton = UIButton.init(type: .detailDisclosure)
        rightButton.tintColor = UIColor(red: 1.00, green: 0.50, blue: 0.00, alpha: 1.0)
        //rightButton.addTarget(self, action: #selector(detailButtonTapped), for: .touchUpInside)
        rightCalloutAccessoryView = rightButton
        
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
