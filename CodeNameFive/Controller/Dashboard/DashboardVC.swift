//
//  DashboardVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 19/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import MaterialProgressBar
class DashboardVC: UIViewController {
    
    
    @IBOutlet weak var googleMapView: GMSMapView!
    weak var gotorider :  Timer?
    var address = ""
    var checkOnlineOrOffline : Bool = false
    @IBOutlet weak var goOnlineOfflineButton: UIButton!
    @IBOutlet weak var timetoConectedLbl: UILabel!
    @IBOutlet weak var findingTripsLbl: UILabel!
    @IBOutlet weak var hamburger: UIView!
    @IBOutlet weak var dashboardBottomView: UIView!

    
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var zoomLevel: Float = 15.0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(menuopen))
        hamburger.addGestureRecognizer(tap)
        
        if !checkOnlineOrOffline{
            
            goOnlineOfflineButton.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
            goOnlineOfflineButton.setTitle("Go online", for: .normal)
            findingTripsLbl.font = UIFont.boldSystemFont(ofSize: 18.0)
            timetoConectedLbl.isHidden = true
            findingTripsLbl.isHidden = true
            //findingTripsLbl.text = "You're offline"
            checkOnlineOrOffline = true
        }
        else{
            
             gotorider =  Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
        }
        LocationManger()
        Autrize()
        //SetupMap()
        
    
        //googleMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 50)
    }

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        dashboardBottomView.addTopBorder(with: UIColor(named: "borderColor")!, andWidth: 1.0)
        dashboardBottomView.addBottomBorder(with: UIColor(named: "borderColor")!, andWidth: 1.0)
        
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    

}




extension DashboardVC{
    @IBAction func OnlineOfflineButton(_ sender: UIButton) {
        
        if checkOnlineOrOffline{
            sender.setBackgroundColor(color: UIColor(named: "dangerHover")!, forState: .highlighted)
            goOnlineOfflineButton.layer.borderWidth = 1
            goOnlineOfflineButton.layer.borderColor = #colorLiteral(red: 0.7803921569, green: 0.137254902, blue: 0.1960784314, alpha: 1)
            goOnlineOfflineButton.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.2078431373, blue: 0.2705882353, alpha: 1)
            goOnlineOfflineButton.setTitle("Go offline", for: .normal)
            timetoConectedLbl.isHidden = false
            findingTripsLbl.text = "Finding trips for you..."
            findingTripsLbl.font = UIFont.boldSystemFont(ofSize: 18.0)
            checkOnlineOrOffline = false
            findingTripsLbl.isHidden = false
            gotorider =  Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
            
        }
        else{
            //goOnlineOfflineButton.centerYAnchor.constraint(equalToSystemSpacingBelow: ce, multiplier: <#T##CGFloat#>)
            sender.setBackgroundColor(color: UIColor(named: "hover")!, forState: .highlighted)
            goOnlineOfflineButton.layer.borderWidth = 1
            goOnlineOfflineButton.layer.borderColor = #colorLiteral(red: 0, green: 0.7490196078, blue: 0.662745098, alpha: 1)
            goOnlineOfflineButton.backgroundColor = #colorLiteral(red: 0, green: 0.8470588235, blue: 0.7529411765, alpha: 1)
            goOnlineOfflineButton.setTitle("Go online", for: .normal)
            timetoConectedLbl.isHidden = true
            findingTripsLbl.isHidden = true
            // findingTripsLbl.text = "You're offline"
            findingTripsLbl.font = UIFont.boldSystemFont(ofSize: 18.0)
            checkOnlineOrOffline = true
            self.gotorider?.invalidate()
        }
        
        
    }
    @IBAction func EarningsButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "EarningsVC") as! EarningsVC
        self.presentOnRoot(viewController: vc)
        
        
        
    }
    func presentOnRoot(viewController : UIViewController){
          let navigationController = UINavigationController(rootViewController: viewController)
          navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
          self.present(navigationController, animated: false, completion: nil)
          
      }

    @objc func menuopen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AppMenu")
        navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func runTimedCode()  {
        //gotorider?.invalidate()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "NewTripRequestVC") as! NewTripRequestVC
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    func Autrize(){
        let locStatus = CLLocationManager.authorizationStatus()
        switch locStatus {
           case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
           return
           case .denied, .restricted:
              let alert = UIAlertController(title: "Location Services are disabled", message: "Please enable Location Services in your Settings", preferredStyle: .alert)
              let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
              alert.addAction(okAction)
              present(alert, animated: true, completion: nil)
           return
           case .authorizedAlways, .authorizedWhenInUse:
           break
        @unknown default:
            fatalError()
        }

    }
    
    
    func LocationManger(){
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.distanceFilter = 50
        locationManager?.startUpdatingLocation()
        locationManager?.delegate = self
    }
    
    
    
    
}

extension DashboardVC: CLLocationManagerDelegate {

 
    func SetupMap() {
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.isHidden = true
    }
    
    
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location: CLLocation = locations.last!

    let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                          longitude: location.coordinate.longitude,
                                          zoom: zoomLevel)
    if mapView.isHidden {
      mapView.isHidden = false
      mapView.camera = camera
    } else {
      mapView.animate(to: camera)
    }

  }

  // Handle authorization for the location manager.
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .restricted:
      print("Location access was restricted.")
    case .denied:
      print("User denied access to location.")
      // Display the map using the default location.
      googleMapView.isHidden = false
    case .notDetermined:
      print("Location status not determined.")
    case .authorizedAlways: fallthrough
    case .authorizedWhenInUse:
      print("Location status is OK.")
    @unknown default:
      fatalError()
    }
  }

  // Handle location manager errors.
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    locationManager.stopUpdatingLocation()
    print("Error: \(error)")
  }
    
    func isAuthorizedtoGetUserLocation() {

        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

