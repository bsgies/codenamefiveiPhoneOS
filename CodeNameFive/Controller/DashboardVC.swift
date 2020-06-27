//
//  DashboardVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 19/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class DashboardVC: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var menuButton: UIButton!
    
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setNeedsStatusBarAppearanceUpdate()
//        let statusBarColor = UIColor(ciColor: .clear)
//        navigationController?.setStatusBar(backgroundColor: statusBarColor)
        menuButton.layer.cornerRadius = menuButton.frame.size.width / 2
        menuButton.layer.shadowColor = UIColor(ciColor: .gray).cgColor
        menuButton.layer.shadowRadius = 1
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // Check for Location Services
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func MenuButtonAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AppMenu")
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {

         super.viewWillAppear(animated)
         navigationController?.setNavigationBarHidden(true, animated: animated)
         
     }
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         navigationController?.setNavigationBarHidden(false, animated: animated)
     }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defer { currentLocation = locations.last }

        if currentLocation == nil {
            // Zoom to user location
            if let userLocation = locations.last {
                let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
                mapView.setRegion(viewRegion, animated: false)
            }
        }
    }

}
