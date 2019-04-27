//
//  ViewController.swift
//  NYUBuzz_LocationProj
//
//  Created by nyuguest on 4/27/19.
//  Copyright © 2019 Team RSM. All rights reserved.
//
// NOTE: much of this code is adapted from the following tutorial by Axel Keel
// https://fluffy.es/current-location/

import UIKit
import CoreLocation

// SUMMARY: ViewController handles delegate mtds for locationManager
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager();  // we use locationManager to retrieve location info

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
