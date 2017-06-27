//
//  ViewController.swift
//  mapprac1
//
//  Created by chang on 2017/6/18.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var myMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let latitude:CLLocationDegrees = 25.0391667
        let longitude:CLLocationDegrees = 121.525
        
        let coordinate: CLLocationCoordinate2D  = CLLocationCoordinate2DMake(latitude, longitude)
        
        let latDelta: CLLocationDegrees = 0.10
        let lonDelta: CLLocationDegrees = 0.10
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        
        myMap.setRegion(region, animated: true)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

