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
    
    var gotorider :  Timer?
    var address = ""
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var menuButton: UIButton!
    
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       gotorider =  Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
        menuButton.layer.cornerRadius = menuButton.frame.size.width / 2
        menuButton.layer.shadowColor = UIColor(ciColor: .gray).cgColor
        menuButton.layer.shadowRadius = 1
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
   @objc func runTimedCode()  {
    gotorider?.invalidate()
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let newViewController = storyBoard.instantiateViewController(withIdentifier: "NewTripRequestVC") as! NewTripRequestVC
    navigationController?.pushViewController(newViewController, animated: true)
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


extension DashboardVC{
    @IBAction func OnlineOfflineButton(_ sender: Any) {
        
        
    }
    @IBAction func EarningsButton(_ sender: Any) {
       let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "EarningsVC") as! EarningsVC
        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(vc, animated: false)
        
    }
}
