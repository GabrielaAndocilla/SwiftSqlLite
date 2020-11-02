//
//  ViewController.swift
//  FotoVideo
//
//  Created by GABRIELA on 6/10/20.
//  Copyright © 2020 com.GABRIELA. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,  CLLocationManagerDelegate  {
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func Localclick(_ sender: Any) {
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    @IBAction func GoFoto(_ sender: Any) {
        let callView = UIStoryboard(name: "Main", bundle: nil)
        let viewGAB = callView.instantiateViewController(withIdentifier: "PhotoVC")
        navigationController?.pushViewController(viewGAB, animated: true)
    }
    
}

