//
//  ViewController.swift
//  NYUBuzz_LocationProj
//
//  Created by nyuguest on 4/27/19.
//  Copyright © 2019 Team RSM. All rights reserved.
//
// NOTE: much of this code is adapted from the following two tutorials by Axel Keel and Andrew Kharchyshyn
// https://fluffy.es/current-location/
// https://www.raywenderlich.com/5247-core-location-tutorial-for-ios-tracking-visited-locations

import UIKit
import CoreLocation

// SUMMARY: ViewController handles delegate mtds for locationManager
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //////////////////////////////
    // VARIABLES
    //////////////////////////////
    
    // UI outlets
    @IBOutlet weak var locAuthZStatus: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    let locationManager = CLLocationManager();  // we use locationManager to retrieve location info
    let geoCoder = CLGeocoder(); // we use geoCoder to convert coordinates to an address
    
    //////////////////////////////
    // METHODS
    //////////////////////////////

    override func viewDidLoad() {
        
        super.viewDidLoad()
        locationManager.delegate = self;
        // ask to updateLocAuthoriz status
        askToEnableLoc()
    }
    
    // user presses "check-in"
    @IBAction func userCheckIn(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    // handles asking user to enable loc services
    func askToEnableLoc() {
        locationManager.requestWhenInUseAuthorization();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //////////////////////////////
    // DELEGATE MTDS FOR LOCMANAGER
    //////////////////////////////
    
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
    
    // called once requestLocation is granted, displ. location to locationLabel
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let authZStatus = CLLocationManager.authorizationStatus();
        
        if (authZStatus == .authorizedAlways || authZStatus == .authorizedWhenInUse) {
            if let location = locations.first {
                // self.locationLabel.text = "\(location.coordinate)";
                
                // converts location to address
                geoCoder.reverseGeocodeLocation(location) { placemarks, _ in
                    if let place = placemarks?.first {
                        let description = "\(place)"
                        self.locationLabel.text = description
                    }
                }
            }
        }
        else {
            self.locationLabel.text = "ERROR: lacking correct locAuthZ status!"
        }
    }
    
    // catches any errors thrown by locationManager calls
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationLabel.text = "locationManager Error: \(error)"
    }
}
