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
import GoogleMaps

class NewTripRequestVC: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {
    
    //MARK:- outlets
    
    @IBOutlet weak var googleMaps: GMSMapView!
    @IBOutlet weak var resturanName: UILabel!
    @IBOutlet weak var resturanAddress: UILabel!
    @IBOutlet weak var deliverAddress: UILabel!
    @IBOutlet weak var remaningTiemForAccepOrder: UIProgressView!
    @IBOutlet weak var cardView: UIView!
    
    //MARK:- variables Declareation
    
    var time : Float = 1
    var timer: Timer?
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    
    
//    let url_string = "URL STRING"
//    let url = URL(string:url_string.addingPercentEncoding(withAllowedCharacters:  CharacterSet.urlQueryAllowed))
//
    
    //MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callWebService()
        //        getPolylineRoute(from: CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0), to: CLLocationCoordinate2D(latitude: 37.45, longitude: -122.0))
        UIDevice.vibrate()
        remaningTiemForAccepOrder.progress = 1
        timer  = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setProgress), userInfo: nil, repeats: true)
        googleMaps.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
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
    
    //MARK:- CardView Customiztion
    
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
    
    
    //MARK:- Light and Dark Mode Delegate
    
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
    
    //MARK:- ProgressBar Timer
    
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
    
    
    //MARK:- Button Actions
    
    @IBAction func AcceptandGo(_ sender: Any) {
        GoToPickup()
    }
    @IBAction func RejectButton(_ sender: UIBarButtonItem) {
        UIDevice.vibrate()
        self.GoToDashBoard()
    }
    @IBAction func menuButton(_ sender: UIBarButtonItem) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AppMenu")
        navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
}

//MARK:- Extenstion

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


extension NewTripRequestVC{
    
    func callWebService(){
        
        let url = NSURL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=Machilipatnam&destination=Vijayawada&mode=driving&key=AIzaSyBXfR7Zu7mvhxO4aydatsUY-VUH-_NG15g")
        
        //let url = NSURL(string: "\("https://maps.googleapis.com/maps/api/directions/json")?origin=\("17.521100"),\("78.452854")&destination=\("15.1393932"),\("76.9214428")")
        
        let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) -> Void in
            
            do {
                if data != nil {
                    let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as!  [String:AnyObject]
                    //                        print(dic)
                    
                    let status = dic["status"] as! String
                    var routesArray:String!
                    if status == "OK" {
                        routesArray = (((dic["routes"]!as! [Any])[0] as! [String:Any])["overview_polyline"] as! [String:Any])["points"] as? String
                    }
                    
                    DispatchQueue.main.async {
                        let path = GMSPath.init(fromEncodedPath: routesArray!)
                        let singleLine = GMSPolyline.init(path: path)
                        singleLine.strokeWidth = 6.0
                        singleLine.strokeColor = .blue
                        singleLine.map = self.googleMaps
                    }
                    
                }
            } catch {
                print("Error")
            }
        }
        
        task.resume()
        
    }
}
