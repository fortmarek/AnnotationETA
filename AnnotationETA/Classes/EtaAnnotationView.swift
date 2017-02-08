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
    
    open var pinColor = UIColor(red: 1.00, green: 0.50, blue: 0.00, alpha: 1.0)
    open var pinSecondaryColor = UIColor.white
    open var rightButton: UIButton?
    
    public override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.annotation = annotation
        self.canShowCallout = true
        self.frame = CGRect(origin: self.frame.origin, size: CGSize(width: 29, height: 43))
        //Bottom part of the pin is on the location, not the center, offset needed
        self.centerOffset = CGPoint(x: 0, y: -(self.frame.height)/2)
        self.backgroundColor = UIColor.clear
        
        
    }
    
    open override var leftCalloutAccessoryView: UIView? {
        didSet {
            leftCalloutAccessoryView?.backgroundColor = pinColor
        }
    }
    
    override open func draw(_ rect: CGRect) {
        
        //Orange Circle
        var bigCircleRect = rect
        bigCircleRect.size.height = rect.size.width
        let path = UIBezierPath(ovalIn: bigCircleRect)
        pinColor.setFill()
        path.fill()
        
        //Bottom part of the pin with arc
        let bottomPath = UIBezierPath()
        bottomPath.move(to: CGPoint(x: 0, y: bigCircleRect.size.height/2 + 2.5))
        bottomPath.addLine(to: CGPoint(x: self.frame.width, y: bigCircleRect.size.height/2 + 2.5))
        bottomPath.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height - 2), radius: 2, startAngle: CGFloat(0), endAngle: CGFloat(M_PI), clockwise: true)
        bottomPath.addLine(to: CGPoint(x: 0, y: bigCircleRect.size.height/2 + 2.5))
        bottomPath.close()
        pinColor.setFill()
        bottomPath.fill()
        
        //small white circle in the center
        let smallSize = bigCircleRect.size.width * 0.5
        let smallCircleRect = CGRect(x: (bigCircleRect.size.width - smallSize)/2, y: (bigCircleRect.size.width - smallSize)/2, width: smallSize, height: smallSize)
        let smallPath = UIBezierPath(ovalIn: smallCircleRect)
        pinSecondaryColor.setFill()
        smallPath.fill()
        

        
    }
    
    public func setDetailShowButton() {
        //Detailed toilet info button
        rightButton = UIButton.init(type: .detailDisclosure)
        rightButton?.tintColor = pinColor
        
        rightCalloutAccessoryView = rightButton
        

    }
    

    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
