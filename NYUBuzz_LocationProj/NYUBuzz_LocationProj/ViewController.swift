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
    
    @IBOutlet weak var locAuthZStatus: UILabel!
    let locationManager = CLLocationManager();  // we use locationManager to retrieve location info

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self;
        // ask to updateLocAuthoriz status
        askToEnableLoc()
    }
    
    
    
    
    
    // handles asking user to enable loc services
    func askToEnableLoc() {
        locationManager.requestWhenInUseAuthorization();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // DELEGATE METHODS FOR LOCATIONMANAGER
    
    // called if loc authoriz. status is changed, updates locAuthStatus
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            locAuthZStatus.text = "authorizedAlways"
        case .authorizedWhenInUse:
            locAuthZStatus.text = "authorizedWhenInUse"
        case .denied:
            locAuthZStatus.text = "denied"
        case .restricted:
            locAuthZStatus.text = "restricted"
        case .notDetermined:
            locAuthZStatus.text = "undetermined"
        }
    }
}
