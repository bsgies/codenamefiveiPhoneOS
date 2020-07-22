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
    
    
    var time : Float = 1
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
        remaningTiemForAccepOrder.progress = 1
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
        
        
        
    }
    func cardViewRadius() {
        cardView.layer.cornerRadius = 5
        cardView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        cardView.layer.masksToBounds = false
    }
    
    func cardViewShadow() {
        cardView.layer.shadowColor = UIColor.white.cgColor
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 3
        
    }
    func cardViewNoShadow() {
        cardView.layer.shadowOpacity = 0
        cardView.layer.shadowColor = UIColor.clear.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if traitCollection.userInterfaceStyle == .light {
            cardViewShadow()
            cardViewRadius()
        }
        else
        {  cardViewNoShadow()
           cardViewRadius()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 13.0, *) {
            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                if traitCollection.userInterfaceStyle == .light {
                    cardViewShadow()
                    cardViewRadius()
                }
                else {
                    cardViewNoShadow()
                    cardViewRadius()
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc  func setProgress() {
        time -= 0.1
        remaningTiemForAccepOrder.progress = time
        
        if time >= 0.1{
            timer?.invalidate()
            remaningTiemForAccepOrder.tintColor = .red
        }
        
        if time == 0.0 {
            timer?.invalidate()
            timer  = nil
            GoToDashBoard()
        }
    }
    
    @IBAction func AcceptandGo(_ sender: Any) {
        GoToPickup()
    }
    @IBAction func RejectButton(_ sender: UIBarButtonItem) {
        UIDevice.vibrate()
        //timer?.invalidate()
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
