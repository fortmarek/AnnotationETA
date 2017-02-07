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
    
    var destinationCoordinate: CLLocationCoordinate2D
    var locationManager: CLLocationManager
    var transportType: MKDirectionsTransportType?
    var destinationName: String?
    
    var imageWidth = CGFloat(0)
    
    public init(destinationCoordinate: CLLocationCoordinate2D, locationManager: CLLocationManager, transportType: MKDirectionsTransportType?, destinationName: String?) {
        self.destinationCoordinate = destinationCoordinate
        self.transportType = transportType
        self.locationManager = locationManager
        self.destinationName = destinationName
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 51))
        
        self.addTarget(self, action: #selector(callGetDirectionsFunc), for: .touchUpInside)
        
        guard
            let transportType = self.transportType,
            let image = transportType.getImage()
        else {return}
        
        //Image
        setImage(image, for: UIControlState())
        setImage(image, for: .highlighted)
        
        //Center image in view
        imageWidth = image.size.width
        let leftImageInset = (frame.size.width - imageWidth) / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: leftImageInset, bottom: 0, right: leftImageInset)
        
        //Title inset
        titleEdgeInsets = UIEdgeInsets(top: 30, left: -imageWidth, bottom: 0, right: 0)
        titleLabel?.textAlignment = .center
        
        
        setEtaTitle()
    }
    
    private func setEtaTitle() {
        
        getEta(completion: {eta in
            
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
    private func animateETA() {
        
        //Start with label rotated upside down to then rotate it to the right angle
        titleLabel?.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI / 2), 1, 0, 0)
        titleLabel?.sizeToFit()
        
        guard let superview = self.superview else {return}
        
        //layoutIfNeeded after sizeToFit() so I don't animate the position of title only rotation
        superview.layoutIfNeeded()
        
        //Image position after adding title
        //Center image in view, 22 is for image width
        let leftImageInset = (frame.size.width - imageWidth) / 2
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
    
        // TODO: Pass maps the adress
        let destinationMapItem = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
        
        if let destinationName = self.destinationName {
            destinationMapItem.name = destinationName
        }
        
        guard let transportType = self.transportType else {return}
        let directionsMode = transportType.getMKLaunchString()
        destinationMapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: directionsMode])
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MKDirectionsTransportType {
    
    fileprivate func getMKLaunchString() -> String {
        switch self.rawValue {
        case 1:
            return MKLaunchOptionsDirectionsModeDriving
        case 2:
            return MKLaunchOptionsDirectionsModeWalking
        case 4:
            if #available(iOS 9.0, *) {
                return MKLaunchOptionsDirectionsModeTransit
            } else {
                return MKLaunchOptionsDirectionsModeDriving
            }
        default:
            return MKLaunchOptionsDirectionsModeDriving
        }
    }
    
    fileprivate func getImage() -> UIImage? {
        switch self.rawValue {
        case 1:
            return UIImage(named: "automobile")
        case 2:
            return UIImage(named: "Walking")
        case 4:
            if #available(iOS 9.0, *) {
                return UIImage(named: "transit")
            } else {
                return UIImage(named: "automobile")
            }
        default:
            return UIImage(named: "automobile")
        }
    }
}



