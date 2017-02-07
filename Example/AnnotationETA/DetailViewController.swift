//
//  DetailViewController.swift
//  AnnotationETA
//
//  Created by Marek Fořt on 2/7/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    var annotation: MKAnnotation?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard
            let annotation = self.annotation,
            let title = annotation.title,
            let subtitle = annotation.subtitle
        else {return}
        
        titleLabel.text = title
        subtitleLabel.text = subtitle
        coordinatesLabel.text = "\(annotation.coordinate.latitude) \(annotation.coordinate.longitude)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dimissDetail(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
