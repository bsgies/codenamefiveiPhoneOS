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
import MaterialProgressBar
class DashboardVC: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var loadingBar: UIProgressView!
    weak var gotorider :  Timer?
    var address = ""
    var checkOnlineOrOffline : Bool = false
    @IBOutlet weak var goOnlineOfflineButton: UIButton!
    @IBOutlet weak var timetoConectedLbl: UILabel!
    @IBOutlet weak var findingTripsLbl: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var menuButton: UIButton!
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    let progressBar = LinearProgressBar()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if !checkOnlineOrOffline{
            
            goOnlineOfflineButton.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
            goOnlineOfflineButton.setTitle("Go online", for: .normal)
            findingTripsLbl.font = UIFont.boldSystemFont(ofSize: 18.0)
            timetoConectedLbl.isHidden = true
            findingTripsLbl.text = "You're offline"
            checkOnlineOrOffline = true
        }
        else{
            
             gotorider =  Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
        }
       
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
        //gotorider?.invalidate()
        //progressBar.stopAnimating()
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
        
        if checkOnlineOrOffline{
            progressBar.tintColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
            self.view.addSubview(progressBar)
            progressBar.startAnimating()
            goOnlineOfflineButton.backgroundColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
            goOnlineOfflineButton.setTitle("Go offline", for: .normal)
            timetoConectedLbl.isHidden = false
            findingTripsLbl.text = "Finding trips for you..."
            findingTripsLbl.font = UIFont.boldSystemFont(ofSize: 18.0)
            checkOnlineOrOffline = false
            gotorider =  Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
            
        }
        else{
            
            goOnlineOfflineButton.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
            goOnlineOfflineButton.setTitle("Go online", for: .normal)
            timetoConectedLbl.isHidden = true
            findingTripsLbl.text = "You're offline"
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
}



extension UIProgressView {

    func startProgressing(duration: TimeInterval, resetProgress: Bool, completion: @escaping () -> Void) {
        stopProgressing()

        // Reset to 0
        progress = 0.0
        layoutIfNeeded()

        // Set the 'destination' progress
        progress = 1.0

        // Animate the progress
        UIView.animate(withDuration: duration, animations: {
            self.layoutIfNeeded()

        }) { finished in
            // Remove this guard-block, if you want the completion to be called all the time - even when the progression was interrupted
           // guard finished else { return }

            if resetProgress { self.progress = 0.0 }

            completion()
        }
    }

    func stopProgressing() {
        // Because the 'track' layer has animations on it, we'll try to remove them
        layer.sublayers?.forEach { $0.removeAllAnimations() }
    }
}
