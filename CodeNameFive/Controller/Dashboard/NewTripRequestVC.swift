//
//  NewTripRequestVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 02/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//


struct MapPath : Decodable{
    var routes : [Route]?
}

struct Route : Decodable{
    var overview_polyline : OverView?
}

struct OverView : Decodable {
    var points : String?
}

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
    var player: AVAudioPlayer?
    var time : Float = 1.0
    var timer: Timer?
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    var fromLoc : CLLocationCoordinate2D?
    var toLoc : CLLocationCoordinate2D?

    //MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound()
        remaningTiemForAccepOrder.progress = 1
        UIDevice.vibrate()
        remaningTiemForAccepOrder.progress = 0
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
      
        
    }

    @objc func updateTimer()
     {
        if time <= 0.0 {
            timer!.invalidate()
            stopPlayer()
            GoToDashBoard()
        }
       
        else {
            time -= 0.01
            remaningTiemForAccepOrder.progress = time
            if time <= 0.4{
            remaningTiemForAccepOrder.tintColor = .red
            }
        
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "noti", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)


            guard let player = player else { return }
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.googleMaps.bringSubviewToFront(cardView)
        if traitCollection.userInterfaceStyle == .light {
            cardViewShadow()
            cardViewRadius()
            mapstyleSilver()
        }
        else
        {  cardViewNoShadow()
            cardViewRadius()
            mapstyleDark()        }
        googleMaps.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        googleMaps.isMyLocationEnabled = true
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            fromLoc = CLLocationCoordinate2DMake((currentLocation?.coordinate.latitude)!, (currentLocation?.coordinate.longitude)!)
            toLoc = CLLocationCoordinate2DMake(((currentLocation?.coordinate.latitude)! + 0.01), ((currentLocation?.coordinate.longitude)! + 0.03))
            
        }
        addMarker()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         let newLocation = locations.last // find your device location
         googleMaps.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 14.0)

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
        cardView.layer.shadowOpacity = 10
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
                    mapstyleSilver()
                }
                else {
                    mapstyleDark()
                    cardViewNoShadow()
                    cardViewRadius()
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    func stopPlayer() {
          if let play = player {
              
              play.pause()
              player = nil
          } else {
              print("player was already deallocated")
          }
      }

    
    
    //MARK:- Button Actions
    
    @IBAction func AcceptandGo(_ sender: Any) {
        timer!.invalidate()
        stopPlayer()
        GoToPickup()
    }
    @IBAction func RejectButton(_ sender: UIBarButtonItem) {
        UIDevice.vibrate()
        timer!.invalidate()
        stopPlayer()
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

    func addMarker(){
        
        let pickupIcon = self.imageWithImage(image: UIImage(named: "Pickup")!, scaledToSize: CGSize(width: 40.0, height: 40.0))
        
        let smarker = GMSMarker()
        smarker.icon = pickupIcon
        smarker.position = self.toLoc!
        smarker.map = self.googleMaps
        
        
        let customerIcon = self.imageWithImage(image: UIImage(named: "Customer")!, scaledToSize: CGSize(width: 50.0, height: 50.0))
        let dmarker = GMSMarker()
        dmarker.icon = customerIcon
        dmarker.position = self.fromLoc!
        dmarker.map = self.googleMaps
        
        let bounds = GMSCoordinateBounds(coordinate: fromLoc!, coordinate: toLoc!)
       // let camera: GMSCameraUpdate = GMSCameraUpdate.fit(bounds)
          let cameraWithPadding: GMSCameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: 100.0)
         self.googleMaps.animate(toZoom: 10)
        self.googleMaps.animate(with: cameraWithPadding)

    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
extension NewTripRequestVC{
    func mapstyle() {
        do {
            
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                googleMaps.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    
    func mapstyleDark() {
        do {
            
            if let styleURL = Bundle.main.url(forResource: "darkstyle", withExtension: "json") {
                googleMaps.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    func mapstyleSilver() {
        do {
            
            if let styleURL = Bundle.main.url(forResource: "Sliver", withExtension: "json") {
                googleMaps.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    func mapstyleDarkMode() {
        do {
            
            if let styleURL = Bundle.main.url(forResource: "DarkModeMap", withExtension: "json") {
                googleMaps.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
}
