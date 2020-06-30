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
    @IBOutlet weak var addressLbl: UILabel!
    var address = ""
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var menuButton: UIButton!
    
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.layer.cornerRadius = menuButton.frame.size.width / 2
        menuButton.layer.shadowColor = UIColor(ciColor: .gray).cgColor
        menuButton.layer.shadowRadius = 1
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            guard let currentLocation = locationManager.location else {
                return
            }
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
//            print("\(self.currentLocation!.coordinate.latitude) and \(String(describing: self.currentLocation?.coordinate.longitude))")
//                       self.userAddres(Latitude: self.currentLocation!.coordinate.latitude, withLongitude: (self.currentLocation?.coordinate.longitude)!)
//        })
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
    
    func userAddres(Latitude: Double, withLongitude Longitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Latitude
        let lon: Double = Longitude
        let geocoder: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


        geocoder.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print(error!.localizedDescription)
                }
                let pm = placemarks! as [CLPlacemark]
                if pm.count > 0 {
                    let placeMark = placemarks![0]
                  
                    if placeMark.subLocality != nil {
                        self.address = self.address + placeMark.subLocality! + ", "
                    }
                    if placeMark.thoroughfare != nil {
                        self.address = self.address + placeMark.thoroughfare! + ", "
                    }
                    if placeMark.locality != nil {
                        self.address = self.address + placeMark.locality! + ", "
                    }
                    if placeMark.country != nil {
                        self.address = self.address + placeMark.country! + ", "
                    }
 
                    self.addressLbl.text = self.address
                    print(self.address)
              }
        })

    }

}
