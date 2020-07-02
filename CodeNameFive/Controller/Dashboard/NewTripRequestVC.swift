//
//  NewTripRequestVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 02/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import MapKit
import CoreHaptics
import AVFoundation
class NewTripRequestVC: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    
    var time : Float = 0
    var timer: Timer?
    @IBOutlet weak var remaningTiemForAccepOrder: UIProgressView!
    @IBOutlet weak var cardView: UIView!
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    @IBOutlet weak var resturanName: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var resturanAddress: UILabel!
    @IBOutlet weak var deliverAddress: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.vibrate()
        timer  = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setProgress), userInfo: nil, repeats: true)
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
    
    @objc  func setProgress() {
        time += 0.1
        remaningTiemForAccepOrder.progress = time
        
        if time >= 0.7{
            remaningTiemForAccepOrder.tintColor = .red
        }
        
        if time >= 1.0 {
            timer!.invalidate()
            GoToDashBoard()
        }
    }
    
    @IBAction func AcceptandGo(_ sender: Any) {
        GoToPickup()
    }
    @IBAction func RejectButton(_ sender: UIBarButtonItem) {
        UIDevice.vibrate()
        timer?.invalidate()
        self.GoToDashBoard()
        
    }
    @IBAction func menuButton(_ sender: UIBarButtonItem) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AppMenu")
        navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    
}

extension NewTripRequestVC{
    
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
    
    
}
extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
 
}
