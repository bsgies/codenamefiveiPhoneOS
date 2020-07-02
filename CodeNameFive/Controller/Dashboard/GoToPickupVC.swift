//
//  GoToPickupVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 03/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import MapKit
class GoToPickupVC: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var timeAndDistance: UILabel!
    @IBOutlet weak var resturentName: UILabel!
    @IBOutlet weak var resturentAddress: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        cardView.layer.shadowColor = UIColor.white.cgColor
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 3
        cardView.layer.cornerRadius = 12
        cardView.layer.masksToBounds = false
    }
    
    @IBAction func menuBarButton(_ sender: UIBarButtonItem) {
        GoToAppMenu()
    }
    @IBAction func helpCenterBarButton(_ sender: UIBarButtonItem) {
        
    }
    @IBAction func callBarButton(_ sender: UIBarButtonItem) {
        phoneNumber()
    }
    @IBAction func deliveryInformationButton(_ sender: UIButton) {
        
    }
    
}


extension GoToPickupVC{
    
    func GoToDashBoard(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC")
        navigationController?.pushViewController(newViewController, animated: true)
    }
    func GoToPickup(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GoToPickupVC")
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func GoToAppMenu() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AppMenu")
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defer { currentLocation = locations.last }
        
        if currentLocation == nil {
            if let userLocation = locations.last {
                let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
                mapView.setRegion(viewRegion, animated: false)
            }
        }
    }
    func phoneNumber(){
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
           ac.addAction(UIAlertAction(title: "+923084706656", style: .default, handler: callingnNumber(action:)))
           ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
           ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
           present(ac, animated: true)
    }
    
    func callingnNumber(action: UIAlertAction) {
        if let url = URL(string: "tel://\("+923084706656")") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }

        }
    }
    
}
