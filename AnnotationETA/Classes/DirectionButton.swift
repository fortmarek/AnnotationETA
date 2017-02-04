//
//  DirectionButton.swift
//  Pods
//
//  Created by Marek Fořt on 2/4/17.
//
//

import Foundation
import MapKit


//DirectionButton
open class DirectionButton: UIButton, DirectionsDelegate {
    
    public var destinationCoordinate: CLLocationCoordinate2D?
    public var transportType: MKDirectionsTransportType?
    public var locationManager: CLLocationManager?
    
    init(destinationCoordinate: CLLocationCoordinate2D) {
        self.destinationCoordinate = destinationCoordinate
        super.init(frame: CGRect(x: 0, y: 0, width: 55, height: 50))
        
        self.addTarget(self, action: #selector(callGetDirectionsFunc), for: .touchUpInside)
        
        //BackgroundColor
        backgroundColor = UIColor(red: 1.00, green: 0.50, blue: 0.00, alpha: 1.0)
        
        //Image
        setImage(UIImage(named: "Walking"), for: UIControlState())
        setImage((UIImage(named: "Walking")), for: .highlighted)
        
        //Center image in view, 22 is for image width
        let leftImageInset = (frame.size.width - 22) / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: leftImageInset, bottom: 0, right: leftImageInset)
        
        //Title inset
        titleEdgeInsets = UIEdgeInsets(top: 30, left: -22.5, bottom: 0, right: 0)
        titleLabel?.textAlignment = .center
    }
    
    
    
    public func setEtaTitle(coordinate: CLLocationCoordinate2D) {
        
        getEta(coordinate, completion: {eta in
            
            //If titleLabel != nil => title is already set, no need for animation
            guard self.titleLabel?.text == nil else {return}
            
            //Title with attributes
            self.titleLabel?.alpha = 0
            let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 10), NSForegroundColorAttributeName: UIColor.white]
            self.setAttributedTitle(NSAttributedString(string: eta, attributes: attributes), for: UIControlState())
            self.setAttributedTitle(NSAttributedString(string: eta, attributes: attributes), for: .highlighted)
            
            self.animateETA()
        })
    }
    
    //Animating appearance of ETA title
    fileprivate func animateETA() {
        
        //Start with label rotated upside down to then rotate it to the right angle
        titleLabel?.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI / 2), 1, 0, 0)
        titleLabel?.sizeToFit()
        
        guard let superview = self.superview else {return}
        
        //layoutIfNeeded after sizeToFit() so I don't animate the position of title only rotation
        superview.layoutIfNeeded()
        
        //Image position after adding title
        //Center image in view, 22 is for image width
        let leftImageInset = (frame.size.width - 22) / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: leftImageInset, bottom: 10, right: leftImageInset)
        
        UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions(), animations: {
            //Rotation - 3D animation
            var perspective = CATransform3DIdentity
            perspective.m34 = -1.0 / 500
            //0, 0, 0, 0 because we want default value (we start this animation with already rotated title)
            self.titleLabel?.layer.transform = CATransform3DConcat(perspective, CATransform3DMakeRotation(0, 0, 0, 0))
            
            //Opacity
            self.titleLabel?.alpha = 1
            
            //Needed to animate imageEdgeInset
            superview.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    func callGetDirectionsFunc(sender: UIButton) {
        guard let destinationCoordinate = self.destinationCoordinate else {return}
        let transportType = self.transportType?.rawValue
        // TODO: Pass maps the adress
        let destinationMapItem = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
        destinationMapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
    }
    
    //Opening Apple maps with directions to the toilet
    func getDirections(coordinate: CLLocationCoordinate2D) {
        
    }
    
//    func getLaunchOptionsMode(transportType: MKDirectionsTransportType) -> String {
//        let tt = transportType
//        switch tt {
//            case .automobile:
//                return MKLaunchOptionsDirectionsModeDriving
//            default:
//                return
//        }
//    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



